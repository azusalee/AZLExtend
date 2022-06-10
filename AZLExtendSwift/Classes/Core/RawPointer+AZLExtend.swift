//
//  RawPointer+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/9/1.
//

import Foundation

extension UnsafeMutableRawPointer {
    
    /// 当作RGBA8888数据来读取
    /// - Parameter offset: 偏移量
    /// - Returns: 颜色
    public func azl_loadAsRGBA8888(offset: Int) -> (r: UInt8, g: UInt8, b: UInt8, a: UInt8) {
        let r = self.load(fromByteOffset: offset, as: UInt8.self)
        let g = self.load(fromByteOffset: offset+1, as: UInt8.self)
        let b = self.load(fromByteOffset: offset+2, as: UInt8.self)
        let a = self.load(fromByteOffset: offset+3, as: UInt8.self)
        
        return (r: r, g: g, b: b, a: a)
    }
    
    /// 当作ARGB8888数据来读取
    /// - Parameter offset: 偏移量
    /// - Returns: 颜色
    public func azl_loadAsARGB8888(offset: Int) -> (r: UInt8, g: UInt8, b: UInt8, a: UInt8) {
        let a = self.load(fromByteOffset: offset, as: UInt8.self)
        let r = self.load(fromByteOffset: offset+1, as: UInt8.self)
        let g = self.load(fromByteOffset: offset+2, as: UInt8.self)
        let b = self.load(fromByteOffset: offset+3, as: UInt8.self)
        
        return (r: r, g: g, b: b, a: a)
    }
}
