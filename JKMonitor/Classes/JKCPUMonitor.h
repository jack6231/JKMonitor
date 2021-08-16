//
//  JKCPUMonitor.h
//  JKMonitor
//
//  Created by 王治恒 on 2021/8/15.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^NoticeBlock)(CGFloat value);

@interface JKCPUMonitor : NSObject

- (void)startMonitoringWithNoticeBlock:(NoticeBlock)noticeBlock;

- (void)stopMonitoring;

@end

NS_ASSUME_NONNULL_END
