//
//  UIScrollView+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/9/1.
//

import UIKit

extension UIScrollView {
    /**
    添加自动根据键盘调整offset的行为
    调用后监听键盘事件，自动调整位置，让响应的textfield或textview不被键盘遮挡
    */ 
    @objc
    public func azl_addAutoAdjustKeyboardAction() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIScrollView.azl_keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIScrollView.azl_keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /**
    移除自动根据键盘调整offset的行为
    与azl_addAutoAdjustKeyboardAction对应
    */ 
    @objc
    public func azl_removeAutoAdjustKeyboardAction() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// 键盘出现事件回调
    @objc
    func azl_keyboardWillAppear(notification:Notification) {
        if let responseView = self.azl_getResponseView() {
            // 找出正在响应的子View
            let user_info = notification.userInfo
            let keyboardRect = (user_info?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            if let responseRect = responseView.superview?.convert(responseView.frame, to: UIApplication.shared.keyWindow) {
                // 计算响应的view为了不让键盘遮挡需要偏移的距离
                let responseBottomInScrollView = responseRect.origin.y+responseRect.size.height+10
                let moveOffset = responseBottomInScrollView-keyboardRect.origin.y;
                
                if moveOffset > 0 {
                    var originOffset = self.contentOffset;
                    originOffset.y += moveOffset;
                    self.setContentOffset(originOffset, animated: true)
                }
            }
            
        }
    }
    
    /// 键盘消失事件 回调
    @objc 
    func azl_keyboardWillDisappear(notification:Notification) {
        // 收起键盘后
        if self.contentOffset.y+self.bounds.size.height > self.contentSize.height {
            self.setContentOffset(CGPoint.init(x: self.contentOffset.x, y: self.contentSize.height-self.bounds.size.height), animated: true)
        }
    }
}
