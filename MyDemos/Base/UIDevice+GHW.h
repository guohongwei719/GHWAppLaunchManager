//
//  UIDevice+GHW.h
//  EasyBike
//
//  Created by ZK on 2017/9/22.
//  Copyright © 2017年 jingyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (GHW)

+ (BOOL)is4;

+ (BOOL)is5;

+ (BOOL)lessThan5;

+ (BOOL)bigThan5;

+ (BOOL)is678;

+ (BOOL)is678P;

+ (BOOL)isX;

+ (CGFloat)stautsBarHeight;

+ (CGFloat)stautsBarAndNaviBarHeight;

+ (CGFloat)tabBarHeight;

+ (CGFloat)safeAreaInsetsBottomHeight;

/**
 *  WiFi开关是否打开
 *
 *  @return 状态
 */
+ (BOOL)isWiFiEnabled;

@end
