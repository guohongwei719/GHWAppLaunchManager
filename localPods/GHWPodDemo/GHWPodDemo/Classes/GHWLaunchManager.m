#import "GHWLaunchManager.h"

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



@interface GHWModuleMetaDataModel : NSObject

@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, assign) IMP imp;

@end

@implementation GHWModuleMetaDataModel


@end




static NSMutableArray<GHWModuleMetaDataModel *> * modulesInDyld(char *key, char *appName) {
    NSMutableArray<GHWModuleMetaDataModel *> * result = [[NSMutableArray alloc] init];

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
            GHWModuleMetaDataModel * metaData = [[GHWModuleMetaDataModel alloc] init];
            metaData.priority = entry.priority;
            metaData.imp = entry.function;
            metaData.info = [NSString stringWithCString:entry.key encoding:NSUTF8StringEncoding];
            [result addObject:metaData];
        }
    }
    
    return [result mutableCopy];

}


__attribute__((constructor))
void premain() {
    NSLog(@"\n\n------------------------  Pre_main start ------------------------\n\n");

    [[GHWLaunchManager sharedInstance] executeArrayForKey:kGHWLauncherStagePreMain];
}

@interface GHWLaunchManager ()


@end

@implementation GHWLaunchManager

+ (instancetype)sharedInstance {
    static GHWLaunchManager *singleTon;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleTon = GHWLaunchManager.new;
    });
    return singleTon;
}

- (void)executeArrayForKey:(NSString *)key {
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
    NSString *fullAppName = [NSString stringWithFormat:@"/%@.app/", appName];
    
    NSString *sectionKey = [NSString stringWithFormat:@"__%@", key];
    NSMutableArray *arrayModule = modulesInDyld((char *)[sectionKey UTF8String], (char *)[fullAppName UTF8String]);
    

    if (!arrayModule.count) {
        return;
    }
    [arrayModule sortUsingComparator:^NSComparisonResult(GHWModuleMetaDataModel * _Nonnull obj1, GHWModuleMetaDataModel * _Nonnull obj2) {
        return obj1.priority < obj2.priority;
    }];
    for (NSInteger i = 0; i < [arrayModule count]; i++) {
        GHWModuleMetaDataModel *model = arrayModule[i];
        IMP imp = model.imp;
        void (*func)(void) = (void *)imp;
        func();
    }
}

- (NSMutableDictionary *)moduleDic {
    if (!_moduleDic) {
        _moduleDic = [[NSMutableDictionary alloc] init];
    }
    return _moduleDic;
}

@end





//void GHWExecuteFunction(char *key, char *appName) {
//    // Podfile 动态库集成方式使用这个方法，遍历加载的每一个动态库，去里面找自定义的 section
//
//    int num = _dyld_image_count();
//    for (int i = 0; i < num; i++) {
//        const char *name = _dyld_get_image_name(i);
//        if (strstr(name, appName) == NULL) {
//            continue;
//        }
//
//        const struct mach_header *header = _dyld_get_image_header(i);
////        printf("%d name: %s\n", i, name);
//
//        Dl_info info;
//        dladdr(header, &info);
//
//        const GHWExportValue dliFbase = (GHWExportValue)info.dli_fbase;
//        const GHWExportSection *section = GHWGetSectByNameFromHeader(header, "__GHW", key);
//        if (section == NULL) continue;
//        int addrOffset = sizeof(struct GHW_Function);
//        for (GHWExportValue addr = section->offset;
//             addr < section->offset + section->size;
//             addr += addrOffset) {
//
//            struct GHW_Function entry = *(struct GHW_Function *)(dliFbase + addr);
//            entry.function();
//
//        }
//    }
//
//
//
//
//
//
//// Podfile 静态库集成方式使用这个方法，不需要遍历加载的每一个动态库，直接想办法读取主 mach-o 二进制文件就行文件，注意修改 dladdr 方法第一个参数
//
////    Dl_info info;
////    dladdr((const void *)&GHWExecuteFunction, &info);
////
////    const GHWExportValue dliFbase = (GHWExportValue)info.dli_fbase;
////    const GHWExportSection *section = GHWGetSectByNameFromHeader((void *)dliFbase, "__GHW", key);
////    if (section == NULL) return;
////
////    int addrOffset = sizeof(struct GHW_Function);
////    for (GHWExportValue addr = section->offset;
////         addr < section->offset + section->size;
////         addr += addrOffset) {
////
////        struct GHW_Function entry = *(struct GHW_Function *)(dliFbase + addr);
////        entry.function();
////    }
//
//
//
//
//
//
//    // 也可以使用getsectiondata获取到指定的section
//    //    unsigned long size;
//    //    struct GHW_Function *ptr = (struct GHW_Function *)getsectiondata(&_mh_execute_header, "__DATA", "__test", &size);
//    //    void (*funP)(void);
//    //    funP = ptr->functionBlock;
//    //    funP();
//    //    ptr->functionBlock();
//}
