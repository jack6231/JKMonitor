//
//  JKTimer.h
//  JKMonitor
//
//  Created by 王治恒 on 2021/8/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKTimer : NSObject

- (void)timeIntervalWithSecs:(float)secs handler:(dispatch_block_t)block;

- (void)invalidate;

@end

NS_ASSUME_NONNULL_END
