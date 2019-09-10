//
//  GHWAttributeBaseObject.m
//  MyDemos
//
//  Created by 黑化肥发灰 on 2019/8/14.
//  Copyright © 2019 Jingyao. All rights reserved.
//

#import "GHWAttributeBaseObject.h"

@implementation GHWAttributeBaseObject

- (void)work __attribute__((objc_requires_super)) {
    NSLog(@"GHWAttributeBaseObject: work");
}

@end
