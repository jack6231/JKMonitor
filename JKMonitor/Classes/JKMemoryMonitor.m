//
//  JKMemoryMonitor.m
//  JKMonitor
//
//  Created by 王治恒 on 2021/8/15.
//

#import "JKMemoryMonitor.h"
#import "JKTimer.h"
#import <sys/sysctl.h>
#import <mach/mach.h>

@interface JKMemoryMonitor()

@property (nonatomic, strong) JKTimer *timer;
@property (nonatomic, copy) NoticeMEMBlock noticeBlock;

@end

@implementation JKMemoryMonitor

- (void)startMonitoringWithNoticeBlock:(NoticeMEMBlock)noticeBlock
{
    if (!noticeBlock) return;
    [self.timer timeIntervalWithSecs:1 handler:^{
        noticeBlock([self usedMemory], [self availableMemory]);
    }];
}

- (void)stopMonitoring
{
    [self.timer invalidate];
}

- (CGFloat)usedMemory {
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t)&vmInfo,&count);

    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return (CGFloat)(vmInfo.phys_footprint / 1024.0 / 1024.0);
}

- (CGFloat)availableMemory
{
    vm_statistics64_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return (CGFloat)(vm_page_size * (vmStats.free_count + vmStats.inactive_count)  / 1024.0 / 1024.0);
}

#pragma mark - lazy load

- (JKTimer *)timer
{
    if (!_timer) {
        _timer = [[JKTimer alloc] init];
    }
    return _timer;
}

@end
