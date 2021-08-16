//
//  JKMonitorWindow.m
//  JKMonitor
//
//  Created by 王治恒 on 2021/8/15.
//

#import "JKMonitorWindow.h"

@interface JKMonitorWindow()

@property (nonatomic, strong) JKMonitorContentView *contentView;

@end

@implementation JKMonitorWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView
{
    _contentView = [[JKMonitorContentView alloc] initWithFrame:CGRectMake(16, 50, 130, 60)];
    [_contentView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewPaned:)]];
    [self addSubview:_contentView];
}

#pragma mark - Gesture

- (void)contentViewPaned:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender translationInView:self.contentView];
    static CGPoint center;
    if (sender.state == UIGestureRecognizerStateBegan) {
        center = sender.view.center;
    }
    CGPoint newCenter = CGPointMake(point.x + center.x, point.y + center.y);
    self.contentView.center = newCenter;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGRectContainsPoint(self.contentView.frame, point)) {
        return YES;
    }
    return NO;
}

@end
