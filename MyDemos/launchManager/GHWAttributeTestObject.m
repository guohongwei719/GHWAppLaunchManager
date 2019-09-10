//
//  GHWAttributeTestObject.m
//  MyDemos
//
//  Created by 黑化肥发灰 on 2019/8/14.
//  Copyright © 2019 Jingyao. All rights reserved.
//

#import "GHWAttributeTestObject.h"

@implementation GHWAttributeTestObject

- (void)testWithSex:(NSString *)sex address:(NSString *)address age:(NSInteger)age __attribute__((nonnull(1,2))) {
    return;
}

- (void)work {
    [super work];
    NSLog(@"GHWAttributeTestObject: work");
}

@end
