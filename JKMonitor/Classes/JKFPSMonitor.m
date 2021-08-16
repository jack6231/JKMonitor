//
//  JKFPSMonitor.m
//  JKMonitor
//
//  Created by 王治恒 on 2021/8/15.
//

#import "JKFPSMonitor.h"
#import <QuartzCore/QuartzCore.h>

@interface JKFPSMonitor()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NoticeBlock noticeBlock;

@end

@implementation JKFPSMonitor

- (void)startMonitoringWithNoticeBlock:(NoticeBlock)noticeBlock
{
    if (!noticeBlock) return;
    self.noticeBlock = noticeBlock;
    self.lastTime = 0;
    self.count = 0;
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopMonitoring
{
    [self.displayLink invalidate];
    self.displayLink = nil;
    self.lastTime = 0;
    self.count = 0;
}

#pragma handler

- (void)displayLinkHandler:(CADisplayLink *)sender
{
    if (self.lastTime == 0) {
        self.lastTime = sender.timestamp;
        return;
    }
    self.count++;
    NSTimeInterval delta = sender.timestamp - self.lastTime;
    if (delta <= 0) {
        return;
    }
    _lastTime = sender.timestamp;
    CGFloat fps = self.count / delta;
    if (self.noticeBlock) {
        self.noticeBlock(fps);
    }
    self.count = 0;
}

#pragma mark - lazy load

- (CADisplayLink *)displayLink
{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkHandler:)];
    }
    return _displayLink;
}

@end
