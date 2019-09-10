//
//  UIDevice+GHW.m
//  EasyBike
//
//  Created by ZK on 2017/9/22.
//  Copyright © 2017年 jingyao. All rights reserved.
//

#import "UIDevice+GHW.h"
#import <ifaddrs.h>
#import <net/if.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation UIDevice (GHW)

+ (BOOL)is4 {
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        return YES;
    }
    return NO;
}

+ (BOOL)is5 {
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        return YES;
    }
    return NO;
}

+ (BOOL)lessThan5 {
    if ([UIDevice is4] || [UIDevice is5]) {
        return YES;
    }
    return NO;
}

+ (BOOL)bigThan5 {
    if ([UIScreen mainScreen].bounds.size.height > 568) {
        return YES;
    }
    return NO;
}

+ (BOOL)is678 {
    if ([UIScreen mainScreen].bounds.size.height == 667) {
        return YES;
    }
    return NO;
}

+ (BOOL)is678P {
    if ([UIScreen mainScreen].bounds.size.height == 736) {
        return YES;
    }
    return NO;
}

+ (BOOL)isX {
    if ([UIScreen mainScreen].bounds.size.height >= 812) {
        return YES;
    }
    return NO;
}

+ (CGFloat)stautsBarHeight {
    return  [UIDevice safeAreaInsetsTopHeight] > 0 ? [UIDevice safeAreaInsetsTopHeight] : 20;
}

+ (CGFloat)stautsBarAndNaviBarHeight {
    return 44.f + [UIDevice stautsBarHeight];
}

+ (CGFloat)tabBarHeight {
    return 49 + [UIDevice safeAreaInsetsBottomHeight];
}

+ (CGFloat)safeAreaInsetsBottomHeight {
    CGFloat gap = 0.f;
    if (@available(iOS 11, *)) {
        if ([UIApplication sharedApplication].keyWindow.safeAreaLayoutGuide.layoutFrame.size.height > 0) {
            gap = ([UIApplication sharedApplication].keyWindow.frame.size.height - [UIApplication sharedApplication].keyWindow.safeAreaLayoutGuide.layoutFrame.origin.y - [UIApplication sharedApplication].keyWindow.safeAreaLayoutGuide.layoutFrame.size.height);
        } else {
            gap = 0;
        }
    } else {
        gap = 0;
    }
    return gap;
}

+ (CGFloat)safeAreaInsetsTopHeight {
    CGFloat gap = 0.f;
    if (@available(iOS 11, *)) {
        gap = [UIApplication sharedApplication].keyWindow.safeAreaLayoutGuide.layoutFrame.origin.y;
    } else {
        gap = 0;
    }
    return gap;
}

+ (BOOL)isWiFiEnabled {
    NSCountedSet * cset = [NSCountedSet new];
    struct ifaddrs *interfaces;
    if( ! getifaddrs(&interfaces) ) {
        for( struct ifaddrs *interface = interfaces; interface; interface = interface->ifa_next) {
            if ( (interface->ifa_flags & IFF_UP) == IFF_UP ) {
                [cset addObject:[NSString stringWithUTF8String:interface->ifa_name]];
            }
        }
    }
    return [cset countForObject:@"awdl0"] > 1 ? YES : NO;
}

@end
