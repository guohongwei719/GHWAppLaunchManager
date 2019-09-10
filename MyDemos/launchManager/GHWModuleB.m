//
//  GHWModuleB.m
//  MyDemos
//
//  Created by 黑化肥发灰 on 2019/8/13.
//  Copyright © 2019 Jingyao. All rights reserved.
//

#import "GHWModuleB.h"

@implementation GHWModuleB

GHW_FUNCTION_EXPORT(Stage_A)() {
    printf("ModuleB:Stage_A\n");
    [[GHWModuleB sharedInstance] initMudule];
}

GHW_FUNCTION_EXPORT(Stage_B)() {
    printf("ModuleB:Stage_B\n");
}

+ (instancetype)sharedInstance {
    static GHWModuleB *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GHWModuleB alloc] init];
    });
    return instance;
}

- (void)initMudule {
    NSLog(@"ModuleB start init ...");
}

@end
