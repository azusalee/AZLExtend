//
//  UIViewController+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/9/1.
//

import UIKit

extension UIViewController {
    
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
    public static func azl_topNaivgationControllerInApp() -> UINavigationController? {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        var topViewController = rootViewController
        var topNaviController:UINavigationController? = nil
        
        while topViewController != nil {
            if let naviVC = topViewController as? UINavigationController {
                topNaviController = naviVC
            }
            topViewController = topViewController?.presentedViewController
        }
        
        return topNaviController
    }
}
