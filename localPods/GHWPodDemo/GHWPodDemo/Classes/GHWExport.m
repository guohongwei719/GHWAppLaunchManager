#import "GHWExport.h"

#import <dlfcn.h>
#import <objc/runtime.h>

#import <mach-o/dyld.h>
#import <mach-o/getsect.h>
#import <mach-o/ldsyms.h>

#ifdef __LP64__
typedef uint64_t GHWExportValue;
typedef struct section_64 GHWExportSection;
#define GHWGetSectByNameFromHeader getsectbynamefromheader_64
#else
typedef uint32_t GHWExportValue;
typedef struct section GHWExportSection;
#define GHWGetSectByNameFromHeader getsectbynamefromheader
#endif

#pragma mark -

void GHWExecuteFunction(char *key, char *appName) {
    // Podfile 动态库集成方式使用这个方法，遍历加载的每一个动态库，去里面找自定义的 section

    int num = _dyld_image_count();
    for (int i = 0; i < num; i++) {
        const char *name = _dyld_get_image_name(i);
        if (strstr(name, appName) == NULL) {
            continue;
        }

        const struct mach_header *header = _dyld_get_image_header(i);
//        printf("%d name: %s\n", i, name);

        Dl_info info;
        dladdr(header, &info);
        
        const GHWExportValue dliFbase = (GHWExportValue)info.dli_fbase;
        const GHWExportSection *section = GHWGetSectByNameFromHeader(header, "__GHW", key);
        if (section == NULL) continue;
        
        int addrOffset = sizeof(struct GHW_Function);
        for (GHWExportValue addr = section->offset;
             addr < section->offset + section->size;
             addr += addrOffset) {
            
            struct GHW_Function entry = *(struct GHW_Function *)(dliFbase + addr);
            entry.function();
        }
    }
    
    
// Podfile 静态库集成方式使用这个方法，不需要遍历加载的每一个动态库，直接想办法读取主 mach-o 二进制文件就行文件，注意修改 dladdr 方法第一个参数

//    Dl_info info;
//    dladdr((const void *)&GHWExecuteFunction, &info);
//
//    const GHWExportValue mach_header = (GHWExportValue)info.dli_fbase;
//    const GHWExportSection *section = GHWGetSectByNameFromHeader((void *)mach_header, "__GHW", key);
//    if (section == NULL) return;
//
//    int addrOffset = sizeof(struct GHW_Function);
//    for (GHWExportValue addr = section->offset;
//         addr < section->offset + section->size;
//         addr += addrOffset) {
//
//        struct GHW_Function entry = *(struct GHW_Function *)(mach_header + addr);
//        entry.function();
//    }
    
    // 也可以使用getsectiondata获取到指定的section
    //    unsigned long size;
    //    struct GHW_Function *ptr = (struct GHW_Function *)getsectiondata(&_mh_execute_header, "__DATA", "__test", &size);
    //    void (*funP)(void);
    //    funP = ptr->functionBlock;
    //    funP();
    //    ptr->functionBlock();
}


@interface GHWExport ()
@end

@implementation GHWExport

+ (instancetype)sharedInstance {
    static GHWExport *singleTon;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleTon = GHWExport.new;
    });
    return singleTon;
}

- (void)executeArrayForKey:(NSString *)key {
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
    NSString *fullAppName = [NSString stringWithFormat:@"/%@.app/", appName];
    
    NSString *fKey = [NSString stringWithFormat:@"__%@", key?:@""];
    
    NSDate *date1 = [NSDate date];
    GHWExecuteFunction((char *)[fKey UTF8String], (char *)[fullAppName UTF8String]);
    NSDate *date2 = [NSDate date];
    NSTimeInterval interval = [date2 timeIntervalSinceDate:date1];
    NSLog(@"%@ 个动态库，遍历时间 timeInterval = %@", @(_dyld_image_count()), @(interval));
    NSLog(@"%@ 个动态库，便利时间 timeInterval = %@", @(_dyld_image_count()), @(interval));
}

- (void)testFail {
    NSArray *array = @[@"1"];
    NSLog(@"test = %@", array[2]);
}

- (void)testSuccess {
    NSLog(@"success");
}

@end
