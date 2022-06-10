//
//  UIViewController+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/9/1.
//

import UIKit

extension UIViewController {

    /// 获取当前keyWindow最顶层的ViewController
    /// - Returns: 当前最顶层的ViewController
    @objc
    public static func azl_topViewControllerInApp() -> UIViewController? {
        if let window = UIApplication.shared.keyWindow {
            return self.azl_topViewController(window: window)
        }
        return nil
    }
    
    /// 获取当前指定window最顶层的ViewController
    /// - Returns: 当前最顶层的ViewController
    @objc
    public static func azl_topViewController(window: UIWindow) -> UIViewController? {
        var controller = window.rootViewController
        
        while controller?.presentedViewController != nil {
            controller = controller?.presentedViewController
        }
        while controller != controller?.azl_topViewController() {
            controller = controller?.azl_topViewController()
        }
        
        return controller
    }
    
    
    /// 最顶层的ViewController
    /// UINavigationController 是topViewController
    /// UITabBarController 是selectedViewController
    /// 其他会返回自身
    /// - Returns: controller
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
  
    /// 获取当前keyWindow最顶层的NavigationViewController
    /// - Returns: UINavigationController
    @objc
    public static func azl_topNaivgationControllerInApp() -> UINavigationController? {
        if let window = UIApplication.shared.keyWindow {
            return self.azl_topNaivgationController(window: window)
        }
        return nil
    }
    
    /// 获取当前指定window最顶层的NavigationViewController
    /// - Returns: UINavigationController
    @objc
    public static func azl_topNaivgationController(window: UIWindow) -> UINavigationController? {
        let rootViewController = window.rootViewController
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
