//
//  GHWAttributeBaseObject.h
//  MyDemos
//
//  Created by 黑化肥发灰 on 2019/8/14.
//  Copyright © 2019 Jingyao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//__attribute__((objc_subclassing_restricted))

@interface GHWAttributeBaseObject : NSObject

- (void)work __attribute__((objc_requires_super));

@end

NS_ASSUME_NONNULL_END
