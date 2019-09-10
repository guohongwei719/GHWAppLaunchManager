//
//  GHWAttributeTestObject.h
//  MyDemos
//
//  Created by 黑化肥发灰 on 2019/8/14.
//  Copyright © 2019 Jingyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHWAttributeBaseObject.h"
NS_ASSUME_NONNULL_BEGIN


__attribute__((objc_runtime_name("GHWRealClassName")))
@interface GHWAttributeTestObject : GHWAttributeBaseObject

- (void)testMethod1 NS_UNAVAILABLE;

- (void)testMethod2 __attribute__((unavailable("这个方法无效了")));

- (void)testWithSex:(NSString *)sex address:(NSString *)address age:(NSInteger)age __attribute__((nonnull(1,2)));


@end

NS_ASSUME_NONNULL_END
