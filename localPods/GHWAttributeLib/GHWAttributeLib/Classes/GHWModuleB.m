//
//  GHWModuleC.m
//  MyDemos
//
//  Created by 黑化肥发灰 on 2019/8/13.
//  Copyright © 2019 黑化肥发灰. All rights reserved.
//

#import "GHWModuleB.h"
#import <GHWPodDemo/GHWLaunchManager.h>
@implementation GHWModuleB

GHW_FUNCTION_EXPORT(Pre_main, kGHWLauncherPriorityHigh)() {
    printf("ModuleB:Pre_main\n");
    [[GHWModuleB sharedInstance] initMudule];
}

GHW_FUNCTION_EXPORT(Stage_A, kGHWLauncherPriorityDefault)() {
    printf("ModuleB:Stage_A\n");
}

GHW_FUNCTION_EXPORT(Stage_B, kGHWLauncherPriorityHigh)() {
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
    NSLog(@"GHWModuleB start init ...");
}

@end
