//
//  GHWLaunchManager.h
//  GHWLaunchManager
//
//  Created by 黑化肥发灰 on 2019/8/13.
//  Copyright © 2019 黑化肥发灰. All rights reserved.
//


#import <Foundation/Foundation.h>

#pragma mark - 存储的结构体
struct GHW_Function {
    char *stage;
    long priority;
    void (*function)(void);
};

#define kGHWLauncherStagePreMain @"Pre_main"
#define kGHWLauncherStageA @"Stage_A"
#define kGHWLauncherStageB @"Stage_B"


#define kGHWLauncherPriorityHigh LONG_MAX
#define kGHWLauncherPriorityDefault 0
#define kGHWLauncherPriorityLow LONG_MIN

#define GHW_FUNCTION_EXPORT(key, _priority_) \
static void _GHW##key(void); \
__attribute__((used, section("__DATA,__launch"))) \
static const struct GHW_Function __F##key = (struct GHW_Function){(char *)(&#key), _priority_, (void *)(&_GHW##key)}; \
static void _GHW##key \

@interface GHWLaunchManager : NSObject

@property (nonatomic, strong) NSMutableDictionary *moduleDic;

+ (instancetype)sharedInstance;
- (void)executeArrayForKey:(NSString *)key;

@end

