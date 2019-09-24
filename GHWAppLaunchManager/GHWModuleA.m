//
//  GHWModuleA.m
//  MyDemos
//
//  Created by 黑化肥发灰 on 2019/8/13.
//  Copyright © 2019 黑化肥发灰. All rights reserved.
//

#import "GHWModuleA.h"
#import <GHWPodDemo/GHWLaunchManager.h>

@implementation GHWModuleA

//GHW_FUNCTION_EXPORT(Pre_main, kGHWLauncherPriorityLow)() {
//    printf("ModuleA:Pre_main\n");
//}

GHW_FUNCTION_EXPORT(Stage_A, kGHWLauncherPriorityHigh)() {
    printf("ModuleA:Stage_A\n");
}


//static void _GHWStage_A(void); \
//__attribute__((used, section("__DATA,__launch"))) \
//static const struct GHW_Function __FStage_A = (struct GHW_Function){(char *)(&("Stage_A")), kGHWLauncherPriorityHigh, (void *)(&_GHWStage_A)}; \
//static void _GHWStage_A () {
//    printf("ModuleA:Stage_A\n");
//}



GHW_FUNCTION_EXPORT(Stage_B, kGHWLauncherPriorityHigh)() {
    printf("ModuleA:Stage_B\n");
    [[GHWModuleA sharedInstance] initMudule];
}

+ (instancetype)sharedInstance {
    static GHWModuleA *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GHWModuleA alloc] init];
    });
    return instance;
}

- (void)initMudule {
    NSLog(@"ModuleA start init ...");
}

@end
