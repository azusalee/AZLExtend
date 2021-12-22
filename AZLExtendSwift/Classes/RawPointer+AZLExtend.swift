//
//  RawPointer+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/9/1.
//

import Foundation

extension UnsafeMutableRawPointer {
    /**
    当作RGBA8888数据来读取
    @param offset 偏移量
    @return UIColor 颜色
    */
    public func azl_loadAsRGBA8888Color(offset: Int) -> UIColor {
        let r = self.load(fromByteOffset: offset, as: UInt8.self)
        let g = self.load(fromByteOffset: offset+1, as: UInt8.self)
        let b = self.load(fromByteOffset: offset+2, as: UInt8.self)
        let a = self.load(fromByteOffset: offset+3, as: UInt8.self)
        
        let color = UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a)/255)
        return color
    }
}
