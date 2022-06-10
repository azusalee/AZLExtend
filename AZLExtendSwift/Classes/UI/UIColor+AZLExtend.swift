//
//  UIColor+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/9/6.
//

import UIKit

extension UnsafeMutableRawPointer {
    
    /// 当作RGBA8888颜色来读取
    /// - Parameter offset: 偏移量
    /// - Returns: 颜色
    public func azl_loadAsRGBA8888Color(offset: Int) -> UIColor {
        let colorData = self.azl_loadAsRGBA8888(offset: offset)
        let color = UIColor(red: CGFloat(colorData.r)/255, green: CGFloat(colorData.g)/255, blue: CGFloat(colorData.b)/255, alpha: CGFloat(colorData.a)/255)
        return color
    }
}

extension UIColor {
    
    /// 从16进制数字生成颜色
    /// - Parameters:
    ///   - rgbValue: 16进制rgb色值 例0xffffff
    ///   - alpha: 透明 取值[0, 1]
    /// - Returns: UIColor 颜色对象
    @objc
    public static func azl_createColor(rgbValue: Int, _ alpha: Float = 1.0) -> UIColor {
        return UIColor(red: CGFloat(CGFloat((rgbValue & 0xFF0000) >> 16)/255), green: CGFloat(CGFloat((rgbValue & 0xFF00) >> 8)/255), blue: CGFloat(CGFloat(rgbValue & 0xFF)/255), alpha: CGFloat(alpha))
    }
    
    /// 从16进制数字生成颜色
    /// - Parameter argbValue: 16进制argb色值 例0xffffffff
    /// - Returns: 颜色对象
    @objc
    public static func azl_createColor(argbValue: Int64) -> UIColor {
        return UIColor(red: CGFloat(CGFloat((argbValue & 0xFF0000) >> 16)/255), green: CGFloat(CGFloat((argbValue & 0xFF00) >> 8)/255), blue: CGFloat(CGFloat(argbValue & 0xFF)/255), alpha: CGFloat(CGFloat((argbValue & 0xFF000000) >> 24)/255))
    }
    
    /// 从16进制字符串生成颜色
    /// - Parameters:
    ///   - colorStr: 16进制rgb色值字符串 例"#ffffff"
    ///   - alpha: 透明 取值[0, 1]
    /// - Returns: UIColor 颜色对象
    @objc
    public static func azl_createColor(colorStr: String, _ alpha: Float = 1.0) -> UIColor {
        var cString: String = colorStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if cString.count != 6 {
            return UIColor.black
        }
        
        let index2 = cString.index(cString.startIndex, offsetBy: 2)
        let index4 = cString.index(cString.startIndex, offsetBy: 4)
        let index6 = cString.index(cString.startIndex, offsetBy: 6)
        
        let rString = cString[cString.startIndex..<index2]
        let gString = cString[index2..<index4]
        let bString = cString[index4..<index6]
        
        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0
        Scanner(string: String(rString)).scanHexInt32(&r)
        Scanner(string: String(gString)).scanHexInt32(&g)
        Scanner(string: String(bString)).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
    }
    
    /// 获取颜色的16进制argb色值
    /// - Returns: Int64 ARGB色值的整形数字 如 白色 0xffffffff
    @objc
    public func azl_argbValue() -> Int64 {
        let myFloatForR = 0
        var r = CGFloat(myFloatForR)
        let myFloatForG = 0
        var g = CGFloat(myFloatForG)
        let myFloatForB = 0
        var b = CGFloat(myFloatForB)
        let myFloatForA = 0
        var a = CGFloat(myFloatForA)
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let colorValue: Int64 = (Int64)((Int64)(a*255)*256*256*256+(Int64)(r*255)*256*256+(Int64)(g*255)*256+(Int64)(b*255))
        return colorValue
    }
}
