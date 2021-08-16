//
//  JKMonitorWindow.h
//  JKMonitor
//
//  Created by 王治恒 on 2021/8/15.
//

#import <UIKit/UIKit.h>
#import "JKMonitorContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JKMonitorWindow : UIWindow

@property (nonatomic, strong, readonly) JKMonitorContentView *contentView;

@end

NS_ASSUME_NONNULL_END
