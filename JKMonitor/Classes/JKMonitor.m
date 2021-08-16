//
//  JKMonitor.m
//  JKMonitor
//
//  Created by 王治恒 on 2021/8/15.
//

#import "JKMonitor.h"
#import "JKMonitorWindow.h"
#import "JKFPSMonitor.h"
#import "JKCPUMonitor.h"
#import "JKMemoryMonitor.h"

@interface JKMonitor()

@property (nonatomic, strong) JKMonitorWindow *window;
@property (nonatomic, strong) JKFPSMonitor *fpsMeonitor;
@property (nonatomic, strong) JKCPUMonitor *cpuMeonitor;
@property (nonatomic, strong) JKMemoryMonitor *memMeonitor;

@end

@implementation JKMonitor

+ (instancetype)sharedInstance
{
    static JKMonitor *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JKMonitor alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _window = [[JKMonitorWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.rootViewController = [[UIViewController alloc] init];
        _window.windowLevel = UIWindowLevelAlert + 1;
        _window.hidden = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (@available(iOS 13.0, *)) {
                for (UIWindowScene *windowScene in [UIApplication sharedApplication].connectedScenes) {
                    if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                      self.window.windowScene = windowScene;
                      break;
                    }
                }
            }
        });
        
        self.fpsMeonitor = [[JKFPSMonitor alloc] init];
        self.cpuMeonitor = [[JKCPUMonitor alloc] init];
        self.memMeonitor = [[JKMemoryMonitor alloc] init];
    }
    return self;
}

- (void)enable
{
    self.window.hidden = NO;
    __weak typeof(self) __weakSelf = self;
    [self.fpsMeonitor startMonitoringWithNoticeBlock:^(CGFloat value) {
        __weakSelf.window.contentView.fpsValue = value;
    }];
    [self.cpuMeonitor startMonitoringWithNoticeBlock:^(CGFloat value) {
        __weakSelf.window.contentView.cpuValue = value * 100;
    }];
    [self.memMeonitor startMonitoringWithNoticeBlock:^(CGFloat usedMemory, CGFloat availableMemory) {
        __weakSelf.window.contentView.usedMemoryValue = usedMemory;
        __weakSelf.window.contentView.availableMemoryValue = availableMemory;
    }];
}

- (void)disable
{
    _window.hidden = YES;
}


@end
