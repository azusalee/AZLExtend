//
//  UIScrollView+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/9/1.
//

import UIKit

extension UIScrollView {
    /// 添加自动根据键盘调整offset的行为
    public func azl_addAutoAdjustKeyboardAction() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIScrollView.azl_keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIScrollView.azl_keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// 移除自动根据键盘调整offset的行为
    public func azl_removeAutoAdjustKeyboardAction() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func azl_keyboardWillAppear(notification:Notification) {
        if let responseView = self.azl_getResponseView() {
            let user_info = notification.userInfo
            let keyboardRect = (user_info?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            if let responseRect = responseView.superview?.convert(responseView.frame, to: UIApplication.shared.keyWindow) {
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
    
    @objc 
    func azl_keyboardWillDisappear(notification:Notification) {
        if self.contentOffset.y+self.bounds.size.height > self.contentSize.height {
            self.setContentOffset(CGPoint.init(x: self.contentOffset.x, y: self.contentSize.height-self.bounds.size.height), animated: true)
        }
    }
}
