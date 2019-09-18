
#import <Foundation/Foundation.h>

#pragma mark - 实现存储方法
struct GHW_Function {
    char *key;
    void (*function)(void);
};

#define GHW_FUNCTION_EXPORT(key) \
static void _GHW##key(void); \
__attribute__((used, section("__GHW,__"#key""))) \
static const struct GHW_Function __F##key = (struct GHW_Function){(char *)(&#key), (void *)(&_GHW##key)}; \
static void _GHW##key \

@interface GHWLaunchManager : NSObject

+ (instancetype)sharedInstance;

/// 执行注册为key的function
- (void)executeArrayForKey:(NSString *)key;
- (void)testFail;
- (void)testSuccess;
@end

