//
//  GHWNewExport.m
//  MyDemos
//
//  Created by 郭宏伟 on 2019/9/8.
//  Copyright © 2019 Jingyao. All rights reserved.
//

#import "GHWNewExport.h"
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

void GHWExecuteFunction(char *key) {

    

    
    // 也可以使用getsectiondata获取到指定的section
    //    unsigned long size;
    //    struct GHW_Function *ptr = (struct GHW_Function *)getsectiondata(&_mh_execute_header, "__DATA", "__test", &size);
    //    void (*funP)(void);
    //    funP = ptr->functionBlock;
    //    funP();
    //    ptr->functionBlock();
}

@implementation GHWNewExport

+ (instancetype)sharedInstance {
    static GHWNewExport *singleTon;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleTon = GHWNewExport.new;
    });
    return singleTon;
}

- (void)executeArrayForKey:(NSString *)key {
    NSString *fKey = [NSString stringWithFormat:@"__%@", key?:@""];
    GHWExecuteFunction((char *)[fKey UTF8String]);
}

@end
