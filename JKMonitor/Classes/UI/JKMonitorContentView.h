//
//  JKMonitorContentView.h
//  JKMonitor
//
//  Created by 王治恒 on 2021/8/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKMonitorContentView : UIView

@property (nonatomic, assign) CGFloat fpsValue;
@property (nonatomic, assign) CGFloat cpuValue;
@property (nonatomic, assign) CGFloat usedMemoryValue;
@property (nonatomic, assign) CGFloat availableMemoryValue;

@end

NS_ASSUME_NONNULL_END
