//
//  JKTimer.m
//  JKMonitor
//
//  Created by 王治恒 on 2021/8/15.
//

#import "JKTimer.h"

@interface JKTimer()

@property (nonatomic, strong) dispatch_source_t dispatchSource;

@end

@implementation JKTimer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    }
    return self;
}

- (void)timeIntervalWithSecs:(float)secs handler:(dispatch_block_t)block
{
    NSParameterAssert(block);
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0), secs * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.dispatchSource, block);
    dispatch_resume(self.dispatchSource);
}

- (void)invalidate
{
    dispatch_source_cancel(self.dispatchSource);
}

@end
