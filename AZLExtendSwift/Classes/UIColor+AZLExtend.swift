//
//  UIColor+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/9/6.
//

import UIKit

extension UIColor {

    // 从16进制数字生成颜色(rgb)
    public static func azl_hexRGB(rgbValue: Int, _ alpha: Float = 1.0) -> UIColor {
        return UIColor(red: CGFloat(CGFloat((rgbValue & 0xFF0000) >> 16)/255), green: CGFloat(CGFloat((rgbValue & 0xFF00) >> 8)/255), blue: CGFloat(CGFloat(rgbValue & 0xFF)/255), alpha: CGFloat(alpha))
    }

    // 从16进制数字生成颜色(argb)
    public static func azl_hexARGB(argbValue: Int64) -> UIColor {
        return UIColor(red: CGFloat(CGFloat((argbValue & 0xFF0000) >> 16)/255), green: CGFloat(CGFloat((argbValue & 0xFF00) >> 8)/255), blue: CGFloat(CGFloat(argbValue & 0xFF)/255), alpha: CGFloat(CGFloat((argbValue & 0xFF000000) >> 24)/255))
    }
    
    // 从16进制字符串生成颜色(#FFFFFF)
    public static func azl_hexString(colorStr: String, _ alpha: Float = 1.0) -> UIColor {
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
}
