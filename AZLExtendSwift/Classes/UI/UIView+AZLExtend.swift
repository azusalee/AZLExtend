//
//  UIView+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/9/1.
//

import UIKit

extension UIView {
    /**
    获取view所在的viewController
    @return UIViewController view所在的viewController
    */ 
    @objc
    public func azl_inViewController() -> UIViewController? {
        var view: UIView? = self
        while view != nil {
            if let nextResponder = view?.next as? UIViewController {
                return nextResponder
            }
            view = view?.superview
        }
        return nil
    }
    
    /**
    获取正在响应的子View
    @return UIVIew 正在响应的子View
    */ 
    @objc
    public func azl_getResponseView() -> UIView? {
        if self.isFirstResponder {
            return self
        }
        for subView in self.subviews {
            if let responseView = subView.azl_getResponseView() {
                return responseView
            }
        }
        return nil
    }
    
    /**
    获取某一点的颜色
    @param point 要取颜色的点
    @return UIColor 颜色
    */
    @objc
    public func azl_color(point: CGPoint) -> UIColor? {
        let bitmapData = malloc(4)
        defer {
            free(bitmapData)
        }
        if let context = CGContext.init(data: bitmapData, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {
            context.translateBy(x: -point.x, y: -point.y)
            self.layer.render(in: context)
            
            return bitmapData?.azl_loadAsRGBA8888Color(offset: 0)
        }
        return nil
    }
    
    // ---- 常用位置扩展
    @objc
    public func azl_top() -> CGFloat {
        return self.frame.origin.y
    }
    
    @objc
    public func azl_left() -> CGFloat {
        return self.frame.origin.x
    }
    
    @objc
    public func azl_width() -> CGFloat {
        return self.frame.size.width
    }
    
    @objc
    public func azl_height() -> CGFloat {
        return self.frame.size.height
    }
    
    @objc
    public func azl_right() -> CGFloat {
        return self.azl_left()+self.azl_width()
    }
    
    @objc
    public func azl_bottom() -> CGFloat {
        return self.azl_top()+self.azl_height()
    }
    
    @objc
    public func azl_centerX() -> CGFloat {
        return self.center.x
    }
    
    @objc
    public func azl_centerY() -> CGFloat {
        return self.center.y
    }
    
    @objc
    public func azl_set(top: CGFloat) {
        var frame = self.frame
        frame.origin.y = top
        self.frame = frame
    }
    
    @objc
    public func azl_set(bottom: CGFloat) {
        self.azl_set(top: bottom-self.azl_height())
    }
    
    @objc
    public func azl_set(left: CGFloat) {
        var frame = self.frame
        frame.origin.x = left
        self.frame = frame 
    }
    
    @objc
    public func azl_set(right: CGFloat) {
        self.azl_set(left: right-self.azl_width())
    }
    
    @objc
    public func azl_set(centerX: CGFloat) {
        self.center = CGPoint.init(x: centerX, y: self.azl_centerY())
    }
    
    @objc
    public func azl_set(centerY: CGFloat) {
        self.center = CGPoint.init(x: self.azl_centerX(), y: centerY)
    }
    
    @objc
    public func azl_set(width: CGFloat) {
        var frame = self.frame
        frame.size.width = width
        self.frame = frame 
    }
    
    @objc
    public func azl_set(height: CGFloat) {
        var frame = self.frame
        frame.size.height = height
        self.frame = frame 
    }
    
}
