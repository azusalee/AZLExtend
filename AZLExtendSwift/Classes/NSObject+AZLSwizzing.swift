//
//  NSObject+AZLSwizzile.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/8/31.
//

import Foundation

public extension NSObject {
    /// 交换实例方法
    class func azl_swizzleInstanceFunc(oriSel: Selector, swizzleSel: Selector) {
        let originalMethod = class_getInstanceMethod(self, oriSel)
        let swizzledMethod = class_getInstanceMethod(self, swizzleSel)
        
        let didAddMethod: Bool = class_addMethod(self, oriSel, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        //如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到 method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
        
        if didAddMethod {
            class_replaceMethod(self, swizzleSel, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
    
    /// 交换类方法
    class func azl_swizzleClassFunc(oriSel: Selector, swizzleSel: Selector) {
        
        let originalMethod = class_getClassMethod(self, oriSel)
        let swizzledMethod = class_getClassMethod(self, swizzleSel)
        
        let didAddMethod: Bool = class_addMethod(self, oriSel, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        //如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到 method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
        
        if didAddMethod {
            class_replaceMethod(self, swizzleSel, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
}
