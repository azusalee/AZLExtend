//
//  NSObject+ALSwizzing.h
//  ALExampleTest
//
//  Created by Mac on 2018/5/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AZLSwizzing)

/// 交换实例方法
+ (void)azl_swizzingInstanceOriginSel:(SEL)originSel swizzledSel:(SEL)swizzingSel;
/// 交换类方法
+ (void)azl_swizzingClassOriginSel:(SEL)originSel swizzledSel:(SEL)swizzingSel;

@end
