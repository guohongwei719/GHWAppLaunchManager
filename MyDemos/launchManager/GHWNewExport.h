//
//  GHWNewExport.h
//  MyDemos
//
//  Created by 郭宏伟 on 2019/9/8.
//  Copyright © 2019 Jingyao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHWNewExport : NSObject

+ (instancetype)sharedInstance;
- (void)executeArrayForKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
