//
//  UIViewController+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/9/1.
//

import UIKit

extension UIViewController {
    /**
    获取当前keyWindow最顶层的ViewController
    @return UIViewController 当前最顶层的ViewController
    */ 
    @objc
    public static func azl_topViewControllerInApp() -> UIViewController? {
        var controller = UIApplication.shared.keyWindow?.rootViewController
        
        while controller?.presentedViewController != nil {
            controller = controller?.presentedViewController
        }
        
        while controller != controller?.azl_topViewController() {
            controller = controller?.azl_topViewController()
        }
        
        return controller
    }
    
    /**
    最顶层的ViewController
    UINavigationController 是topViewController
    UITabBarController 是selectedViewController
    其他会返回自身
    @return UIViewController
     */
    @objc
    public func azl_topViewController() -> UIViewController? {
        if let navVC = self as? UINavigationController {
            return navVC.topViewController
        } else if let tabVC = self as? UITabBarController {
            return tabVC.selectedViewController
        } 
        return self
    }
    
}

extension UINavigationController {
    /**
    获取当前keyWindow最顶层的NavigationViewController
    @return UINavigationController
    */ 
    @objc
    public static func azl_topNaivgationControllerInApp() -> UINavigationController? {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        var topViewController = rootViewController
        var topNaviController: UINavigationController? = nil
        
        while topViewController != nil {
            if let naviVC = topViewController as? UINavigationController {
                topNaviController = naviVC
            }
            topViewController = topViewController?.presentedViewController
        }
        
        return topNaviController
    }
}
