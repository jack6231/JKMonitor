//
//  JKMonitor.h
//  JKMonitor
//
//  Created by 王治恒 on 2021/8/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKMonitor : NSObject

+ (instancetype)sharedInstance;

- (void)enable;
- (void)disable;

@end

NS_ASSUME_NONNULL_END
