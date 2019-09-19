
#import <Foundation/Foundation.h>

#pragma mark - 实现存储方法
struct GHW_Function {
    long priority;
    char *key;
    void (*function)(void);
};

#define kGHWLauncherStagePreMain @"Pre_main"
#define kGHWLauncherStageA @"Stage_A"
#define kGHWLauncherStageB @"Stage_B"

#define kGHWLauncherStagePreMainSimple Pre_main
#define kGHWLauncherStageASimple Stage_A
#define kGHWLauncherStageBSimple Stage_B

#define kGHWLauncherPriorityHigh LONG_MAX
#define kGHWLauncherPriorityDefault 0
#define kGHWLauncherPriorityLow LONG_MIN

#define GHW_FUNCTION_EXPORT(key, _priority_) \
static void _GHW##key(void); \
__attribute__((used, section("__GHW,__"#key""))) \
static const struct GHW_Function __F##key = (struct GHW_Function){_priority_, (char *)(&#key), (void *)(&_GHW##key)}; \
static void _GHW##key \

@interface GHWLaunchManager : NSObject

@property (nonatomic, strong) NSMutableDictionary *moduleDic;


+ (instancetype)sharedInstance;

/// 执行注册为key的function
- (void)executeArrayForKey:(NSString *)key;

@end

