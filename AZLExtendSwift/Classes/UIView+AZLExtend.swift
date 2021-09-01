//
//  UIView+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/9/1.
//

import UIKit

extension UIView {
    /// 获取view所在的viewController
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
    
    /// 获取正在响应的子View
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
    
    /// 获取某一点的颜色
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
}
