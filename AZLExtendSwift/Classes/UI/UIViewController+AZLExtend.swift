//
//  UIViewController+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/9/1.
//

import UIKit

extension UIViewController {

//    /// 获取当前keyWindow最顶层的ViewController
//    /// - Returns: 当前最顶层的ViewController
//    @objc
//    public static func azl_topViewControllerInApp() -> UIViewController? {
//        if let window = UIApplication.shared.keyWindow {
//            return self.azl_topViewController(window: window)
//        }
//        return nil
//    }
    
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
    
    // 键盘自动调节
    /// 添加键盘自动调节监听
    public func azl_addAutoAdjustKeyboardAction() {
        NotificationCenter.default.addObserver(self, selector: #selector(azl_keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(azl_keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// 移除键盘自动调节监听
    public func azl_removeAutoAdjustKeyboardAction() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// 键盘出现事件 回调
    /// 使用这个方发时，不能对controller的view的transform进行修改，不然显示上可能会不对
    @objc
    private func azl_keyboardWillAppear(notification: Notification) {
        if let responseView = self.view.azl_getResponseView() {
            // 找出正在响应的子View
            let user_info = notification.userInfo
            let keyboardRect = (user_info?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            if let responseRect = responseView.superview?.convert(responseView.frame, to: UIApplication.shared.keyWindow) {
                // 计算响应的view为了不让键盘遮挡需要偏移的距离
                let responseBottomInScrollView = responseRect.origin.y+responseRect.size.height+10
                let moveOffset = responseBottomInScrollView-keyboardRect.origin.y;
                
                if moveOffset > 0 {
                    UIView.animate(withDuration: 0.275) {
                        self.view.transform = CGAffineTransformMakeTranslation(0, -moveOffset)
                    }
                }
            }
            
        }
    }
    
    /// 键盘消失事件 回调
    @objc
    private func azl_keyboardWillDisappear(notification: Notification) {
        // 收起键盘后，恢复
        if self.view.transform != CGAffineTransformIdentity {
            UIView.animate(withDuration: 0.275) {
                self.view.transform = CGAffineTransformIdentity
            }
        }
    }
}

extension UINavigationController {
  
//    /// 获取当前keyWindow最顶层的NavigationViewController
//    /// - Returns: UINavigationController
//    @objc
//    public static func azl_topNaivgationControllerInApp() -> UINavigationController? {
//        if let window = UIApplication.shared.keyWindow {
//            return self.azl_topNaivgationController(window: window)
//        }
//        return nil
//    }
    
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
