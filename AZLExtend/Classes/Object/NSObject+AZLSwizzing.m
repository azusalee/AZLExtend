//
//  NSObject+ALSwizzing.m
//  ALExampleTest
//
//  Created by Mac on 2018/5/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "NSObject+AZLSwizzing.h"
#import <objc/runtime.h>

@implementation NSObject (AZLSwizzing)

//实例方法交换
+ (void)azl_swizzingInstanceOriginSel:(SEL)originSel swizzledSel:(SEL)swizzingSel{
    Method originMethod = class_getInstanceMethod(self, originSel);
    Method swizzingMethod = class_getInstanceMethod(self, swizzingSel);
    
    BOOL isAdd = class_addMethod(self, originSel, method_getImplementation(swizzingMethod), method_getTypeEncoding(swizzingMethod));
    if (isAdd) {
        class_replaceMethod(self, swizzingSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzingMethod);
    }
}

//类方法交换
+ (void)azl_swizzingClassOriginSel:(SEL)originSel swizzledSel:(SEL)swizzingSel{
    //当self为类的时候object_getClass(self)获得的是Metaclass
    //Metaclass与Class的结构是一样的，只是职能不同。Class结构中是存储Object实例的相关数据，而Metaclass则是存储Class相关的数据。
    Class cls = object_getClass(self);
    Method originMethod = class_getClassMethod(cls, originSel);
    Method swizzingMethod = class_getClassMethod(cls, swizzingSel);
    
    BOOL isAdd = class_addMethod(cls, originSel, method_getImplementation(swizzingMethod), method_getTypeEncoding(swizzingMethod));
    if (isAdd) {
        class_replaceMethod(cls, swizzingSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzingMethod);
    }
}


@end
