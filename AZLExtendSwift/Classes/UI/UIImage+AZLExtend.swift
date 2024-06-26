//
//  UIImage+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2019/1/21.
//

import UIKit
import Accelerate

/// 常用图片处理的扩展方法
public extension UIImage {
    
    /// 从url生成缩略图(指定大小)
    /// - Parameters:
    ///   - url: 本地的路径url
    ///   - size: 生成的图片大小
    /// - Returns: 图片对象
    @objc class func azl_imageFrom(url: URL, size: CGSize) -> UIImage? {
        let scale = UIScreen.main.scale
        
        let sourceOpt = [kCGImageSourceShouldCache : false] as CFDictionary
        if let source = CGImageSourceCreateWithURL(url as CFURL, sourceOpt) {
            let maxDimension = max(size.width, size.height) * scale
            let thumbnailOpt = [kCGImageSourceCreateThumbnailFromImageAlways : true,
                                kCGImageSourceShouldCacheImmediately : true ,
                                kCGImageSourceCreateThumbnailWithTransform : true,
                                kCGImageSourceThumbnailMaxPixelSize : maxDimension] as CFDictionary
            let thumbnailImage = CGImageSourceCreateThumbnailAtIndex(source, 0, thumbnailOpt)!
            
            return UIImage(cgImage: thumbnailImage)
        }
        
        return nil
    }
    
    /// 从data生成缩略图(指定大小)
    /// - Parameters:
    ///   - data: 图片的data数据
    ///   - size: 生成的图片大小
    /// - Returns: 图片对象
    @objc class func azl_imageFrom(data: Data, size: CGSize) -> UIImage? {
        let scale = UIScreen.main.scale
        
        let sourceOpt = [kCGImageSourceShouldCache : false] as CFDictionary
        if let source = CGImageSourceCreateWithData(data as CFData, sourceOpt) {
            let maxDimension = max(size.width, size.height) * scale
            let thumbnailOpt = [kCGImageSourceCreateThumbnailFromImageAlways : true,
                                kCGImageSourceShouldCacheImmediately : true ,
                                kCGImageSourceCreateThumbnailWithTransform : true,
                                kCGImageSourceThumbnailMaxPixelSize : maxDimension] as CFDictionary
            let thumbnailImage = CGImageSourceCreateThumbnailAtIndex(source, 0, thumbnailOpt)!
            
            return UIImage(cgImage: thumbnailImage)
        }
        
        return nil
    }
    
    /// 生成纯色图片
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 大小
    /// - Returns: 图片对象
    @objc class func azl_imageFrom(color: UIColor, size: CGSize = CGSize.init(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 从view生成图片(截图)
    /// - Parameter view: 视图对象
    /// - Returns: 图片对象
    @objc class func azl_imageFrom(view: UIView) -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, scale)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// 预解压
    /// - Parameter cgImage: 解压前的图片
    /// - Returns: 解压后的图片
    @objc class func azl_preDecode(cgImage: CGImage) -> CGImage? {
        let width = cgImage.width
        let height = cgImage.height
        
        var bitmapInfo = CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.noneSkipFirst.rawValue
        if cgImage.alphaInfo == .first || cgImage.alphaInfo == .last || cgImage.alphaInfo == .premultipliedFirst || cgImage.alphaInfo == .premultipliedLast {
            bitmapInfo = CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue
        }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        if let context = CGContext.init(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo) {
            context.draw(cgImage, in: CGRect.init(x: 0, y: 0, width: width, height: height))
            let newImage = context.makeImage()
            return newImage
        }
        return nil
    }
    
    
    // ----  实例方法
    
    /// 把图片缩放到指定size
    /// - Parameter size: 图片大小
    /// - Returns: 图片对象
    @objc func azl_scaleImage(size: CGSize) -> UIImage? {
        return azl_scaleImage(size: size, scale: self.scale)
    }
    
    /// 把图片缩放到指定size
    /// - Parameter size: 图片大小
    /// - Returns: 图片对象
    @objc func azl_scaleImage(size: CGSize, scale: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.draw(in: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size))
        let scaleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaleImage
    }
    
    /// 根据宽等比缩放
    /// - Parameter width: 缩放后的宽度
    /// - Returns: 图片对象
    @objc func azl_scaleImage(width: CGFloat) -> UIImage? {
        return self.azl_scaleImage(width: width, scale: self.scale)
    }
    
    /// 根据宽等比缩放
    /// - Parameter width: 缩放后的宽度
    /// - Returns: 图片对象
    @objc func azl_scaleImage(width: CGFloat, scale: CGFloat) -> UIImage? {
        if self.size.width == 0 || self.size.height == 0 {
            return nil
        }
        let height = width*(self.size.height/self.size.width)
        return self.azl_scaleImage(size: CGSize.init(width: width, height: height), scale: scale)
    }
    
    /// 根据高等比缩放
    /// - Parameter height: 缩放后的高度
    /// - Returns: 图片对象
    @objc func azl_scaleImage(height: CGFloat) -> UIImage? {
        return self.azl_scaleImage(height: height, scale: self.scale)
    }
    
    /// 根据高等比缩放
    /// - Parameter height: 缩放后的高度
    /// - Returns: 图片对象
    @objc func azl_scaleImage(height: CGFloat, scale: CGFloat) -> UIImage? {
        if self.size.width == 0 || self.size.height == 0 {
            return nil
        }
        let width = height*(self.size.width/self.size.height)
        return self.azl_scaleImage(size: CGSize.init(width: width, height: height), scale: scale)
    }
    
    /// 裁剪图片
    /// - Parameter rect:  裁剪的范围
    /// - Returns: 图片对象
    @objc func azl_clipImage(rect: CGRect) -> UIImage? {
        let scale = self.scale
        if let subImage = self.cgImage?.cropping(to: CGRect.init(x: rect.origin.x*scale, y: rect.origin.y*scale, width: rect.size.width*scale, height: rect.size.height*scale)) {
            return UIImage(cgImage: subImage, scale: scale, orientation: self.imageOrientation)
        }
        return nil
    }
    
    /// 内切圆(椭圆)裁剪
    /// - Parameter rect: 裁剪的范围
    /// - Returns: 图片对象
    @objc func azl_clipCircleImage(rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        
        context?.addEllipse(in: CGRect.init(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
        context?.clip()
        self.draw(at: CGPoint.init(x: -rect.origin.x, y: -rect.origin.y))
        let clipImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return clipImage
    }
    
    /// 圆角裁剪
    /// - Parameters:
    ///   - radius: 圆角半径
    ///   - corners: 需要裁剪的圆角
    /// - Returns: 图片对象
    @objc func azl_clipCornerImage(radius: CGFloat, corners: UIRectCorner = .allCorners) -> UIImage? {
        let size = self.size
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        
        let path = UIBezierPath.init(roundedRect: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size), byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
        context?.addPath(path.cgPath)
        context?.clip()
        self.draw(at: CGPoint.init(x: 0, y: 0))
        let clipImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return clipImage
    }
    
    /// 圆裁剪
    /// - Parameters:
    ///   - point: 圆心
    ///   - radius: 半径
    /// - Returns: 图片对象
    @objc func azl_clipCircleImage(point: CGPoint, radius: CGFloat) -> UIImage? {
        let rect = CGRect.init(x: point.x-radius, y: point.y-radius, width: radius*2, height: radius*2)
        return self.azl_clipCircleImage(rect: rect)
    }
    
    /// 灰度图
    /// - Returns: 图片对象
    @objc func azl_grayImage() -> UIImage? {
        let width:Int = Int(self.size.width*self.scale)
        let height:Int = Int(self.size.height*self.scale)
        
        let colorSpace = CGColorSpaceCreateDeviceGray()
        guard let oriCGImage = self.cgImage else {
            return nil
        }
        guard let context = CGContext.init(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue).rawValue) else {
            return nil
        }
        context.draw(oriCGImage, in: CGRect.init(x: 0, y: 0, width: width, height: height))
        if let cgImage = context.makeImage() {
            let grayImage = UIImage.init(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
            return grayImage
        }
        return nil
    }
    
    /// 灰度渐隐
    /// - Returns: 图片对象
    @objc func azl_grayAlphaImage() -> UIImage? {
        if let imageRef = self.cgImage {
            let width = imageRef.width
            let height = imageRef.height
            let bitmapData = malloc(width*height*1*4)
            defer {
                free(bitmapData)
            }
            
            if let context = CGContext.init(data: bitmapData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width*4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {
                let rect = CGRect.init(x: 0, y: 0, width: width, height: height)
                context.clear(rect)
                context.draw(imageRef, in: rect)
                
                var i = 0
                var j = 0
                while i < width {
                    j = 0
                    while j < height {
                        let index = j*width+i
                        // 获取每一点的rgb
                        let r = bitmapData?.load(fromByteOffset: index*4, as: UInt8.self) ?? 0
                        let g = bitmapData?.load(fromByteOffset: index*4+1, as: UInt8.self) ?? 0
                        let b = bitmapData?.load(fromByteOffset: index*4+2, as: UInt8.self) ?? 0
                        
                        var gray = Double(r) * 0.2126
                        gray += Double(g) * 0.7152 + Double(b) * 0.0722
                        if gray > 255 {
                            gray = 255
                        }
                        let grayInt = UInt8(gray)
                        
                        // 替换每一点的rgba
                        bitmapData?.storeBytes(of: grayInt, toByteOffset: index*4, as: UInt8.self)
                        bitmapData?.storeBytes(of: grayInt, toByteOffset: index*4+1, as: UInt8.self)
                        bitmapData?.storeBytes(of: grayInt, toByteOffset: index*4+2, as: UInt8.self)
                        bitmapData?.storeBytes(of: grayInt, toByteOffset: index*4+3, as: UInt8.self)
                        
                        j += 1
                    }
                    i += 1
                }
                
                if let cgImage = context.makeImage() {
                    return UIImage.init(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
                }
            }
        }
        return nil
    }
    
    /// 透明翻转图
    /// - Returns: 图片对象
    @objc func azl_reverseAlphaImage() -> UIImage? {
        if let imageRef = self.cgImage {
            let width = imageRef.width
            let height = imageRef.height
            let bitmapData = malloc(width*height*1*4)
            defer {
                free(bitmapData)
            }
            
            if let context = CGContext.init(data: bitmapData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width*4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {
                let rect = CGRect.init(x: 0, y: 0, width: width, height: height)
                context.clear(rect)
                context.draw(imageRef, in: rect)
                
                var i = 0
                var j = 0
                while i < width {
                    j = 0
                    while j < height {
                        let index = j*width+i
                        // 获取每一点的rgba
                        let r = bitmapData?.load(fromByteOffset: index*4, as: UInt8.self) ?? 0
                        let g = bitmapData?.load(fromByteOffset: index*4+1, as: UInt8.self) ?? 0
                        let b = bitmapData?.load(fromByteOffset: index*4+2, as: UInt8.self) ?? 0
                        let a = bitmapData?.load(fromByteOffset: index*4+3, as: UInt8.self) ?? 0
                        
                        let newa = 255-a
                        
                        // 替换每一点的a
//                        bitmapData?.storeBytes(of: r, toByteOffset: index*4, as: UInt8.self)
//                        bitmapData?.storeBytes(of: g, toByteOffset: index*4+1, as: UInt8.self)
//                        bitmapData?.storeBytes(of: b, toByteOffset: index*4+2, as: UInt8.self)
                        bitmapData?.storeBytes(of: newa, toByteOffset: index*4+3, as: UInt8.self)
                        
                        j += 1
                    }
                    i += 1
                }
                
                if let cgImage = context.makeImage() {
                    return UIImage.init(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
                }
            }
        }
        return nil
    }
    
    /// 模糊图
    /// - Parameter blur: 模糊值
    /// - Returns: 图片对象
    @objc func azl_boxBlurImage(blur: CGFloat) -> UIImage? {
        var fixBlur = blur
        if blur < 0 || blur > 1 {
            fixBlur = 0.5
        }
        
        var boxSize:Int = Int(fixBlur*50)
        boxSize = boxSize - (boxSize % 2) + 1
        
        let tmpImage = self.azl_scaleImage(width: self.size.width)
        
        if let img = tmpImage?.cgImage {
            
            if let inProvider = img.dataProvider {
                let height = vImagePixelCount(img.height)
                let width = vImagePixelCount(img.width)
                let rowBytes = img.bytesPerRow
                let inBitmapData = inProvider.data
                let inData = UnsafeMutableRawPointer(mutating: CFDataGetBytePtr(inBitmapData))
    
                var inBuffer = vImage_Buffer(data: inData, height: height, width: width, rowBytes: rowBytes)
                let outData = malloc(img.bytesPerRow*img.height)
                var outBuffer = vImage_Buffer(data: outData, height: height, width: width, rowBytes: rowBytes)
                defer {
                    //free(inData)
                    free(outData)
                }
                
                vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
                //vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
                //vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
                
                let ctx = CGContext.init(data: outBuffer.data, width: Int(outBuffer.width), height: Int(outBuffer.height), bitsPerComponent: 8, bytesPerRow: outBuffer.rowBytes, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: img.bitmapInfo.rawValue) 
                
                if let cgImage = ctx?.makeImage() {
                    return UIImage.init(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
                }
                
            }
        }
        
        return nil
    }
    
    /// 马赛克图
    /// - Parameter level: 马赛克大小 (4代表一格马赛克占4*4)
    /// - Returns: 图片对象
    @objc func azl_mosaicImage(level: Int) -> UIImage? {
        if level < 2 {
            return self
        }
        if let imageRef = self.cgImage {
            let width = imageRef.width
            let height = imageRef.height
            let bitmapData = malloc(width*height*1*4)
            defer {
                free(bitmapData)
            }
            
            if let context = CGContext.init(data: bitmapData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width*4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {
                
                let rect = CGRect.init(x: 0, y: 0, width: width, height: height)
                context.clear(rect)
                context.draw(imageRef, in: rect)
                
                var i = 0
                var j = 0
                while i < width {
                    j = 0
                    while j < height {
                        let index = j*width+i
                        var preIndex = index
                        if j%level == 0 {
                            if i%level != 0 {
                                preIndex = j*width+i-1
                            }
                        }else{
                            preIndex = (j-1)*width+i
                        }
                        
                        if preIndex != index {
                            // 获取每一点的rgba
                            let r = bitmapData?.load(fromByteOffset: preIndex*4, as: UInt8.self) ?? 0
                            let g = bitmapData?.load(fromByteOffset: preIndex*4+1, as: UInt8.self) ?? 0
                            let b = bitmapData?.load(fromByteOffset: preIndex*4+2, as: UInt8.self) ?? 0
                            let a = bitmapData?.load(fromByteOffset: preIndex*4+3, as: UInt8.self) ?? 0
                            
                            // 替换每一点的rgba
                            bitmapData?.storeBytes(of: r, toByteOffset: index*4, as: UInt8.self)
                            bitmapData?.storeBytes(of: g, toByteOffset: index*4+1, as: UInt8.self)
                            bitmapData?.storeBytes(of: b, toByteOffset: index*4+2, as: UInt8.self)
                            bitmapData?.storeBytes(of: a, toByteOffset: index*4+3, as: UInt8.self)
                        }
                        
                        j += 1
                    }
                    i += 1
                }
                
                if let cgImage = context.makeImage() {
                    return UIImage.init(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
                }
            }
        }
        return nil
    }
    
    /// 旋转角度（如90，180之类的）
    /// - Parameter rotateAngle: 旋转角度（如90，180之类的）
    /// - Returns: 图片对象
    @objc func azl_rotateImage(rotateAngle: Double) -> UIImage? {
        let radian = CGFloat(Double.pi*rotateAngle/180)
        let transform = CGAffineTransform(rotationAngle: radian)
        let rotateRect = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height).applying(transform)
        UIGraphicsBeginImageContextWithOptions(rotateRect.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: rotateRect.size.width/2, y: rotateRect.size.height/2)
        context?.rotate(by: radian)
        context?.translateBy(x: -self.size.width/2, y: -self.size.height/2)
        self.draw(at: .zero)
        let rotateImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rotateImage
    }
    
    /// 翻转图
    /// - Parameter isVertical: true: 垂直翻转 false: 水平翻转
    /// - Returns: 图片对象
    @objc func azl_mirrorImage(isVertical: Bool) -> UIImage? {
        let rect = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.clip(to: rect)
        
        if isVertical == false {
            context?.rotate(by: CGFloat.pi)
            context?.translateBy(x: -rect.size.width, y: -rect.size.height)
        }
        
        if let cgImage = self.cgImage {
            context?.draw(cgImage, in: rect)
        }
        
        var mirrorImage = UIGraphicsGetImageFromCurrentImageContext()
        if let cgImage = mirrorImage?.cgImage {
            mirrorImage = UIImage.init(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
        }
        
        UIGraphicsEndImageContext()
        return mirrorImage
    }
    
    /// 获取某点的颜色
    /// - Parameter point: 图片坐标点(从左上到右下计)
    /// - Returns: 颜色
    @objc func azl_color(point: CGPoint) -> UIColor? {
        
        let image = self
        let rect = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)
        if rect.contains(point) == false {
            return nil
        }
        guard let cgImage = self.cgImage else {
            return nil
        }
        
        let pointx = trunc(point.x)
        let pointy = trunc(point.y)
        
        let bitmapData = malloc(4)
        defer {
            free(bitmapData)
        }
        
        if let context = CGContext.init(data: bitmapData, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGImageByteOrderInfo.order32Big.rawValue) {
            context.setBlendMode(.copy)
            context.translateBy(x: -pointx, y: pointy-image.size.height+1)
            context.draw(cgImage, in: rect)
            
            return bitmapData?.azl_loadAsRGBA8888Color(offset: 0)
        }
        
        return nil
    }
    
    /// 变色图片
    /// - Parameters:
    ///   - color: 变化的颜色
    ///   - blendMode: 颜色混合的方式
    /// - Returns: 图片对象
    @objc func azl_tintImage(color: UIColor, blendMode: CGBlendMode = .destinationIn) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        let rect = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(rect)
        
        self.draw(in: rect, blendMode: blendMode, alpha: 1.0)
        if blendMode != .destinationIn {
            self.draw(in: rect, blendMode: .destinationIn, alpha: 1.0)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 不透明像素的占所有像素的百分比
    /// - Returns: 不透明像素的占所有像素的百分比 取值[0, 1]
    @objc func azl_alphaPixelRate() -> Double {
        if let imageRef = self.cgImage {
            let width = imageRef.width
            let height = imageRef.height
            let bitmapData = malloc(width*height)
            defer {
                free(bitmapData)
            }
            
            if let context = CGContext.init(data: bitmapData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width, space: CGColorSpaceCreateDeviceGray(), bitmapInfo: CGImageAlphaInfo.alphaOnly.rawValue) {
                let rect = CGRect.init(x: 0, y: 0, width: width, height: height)
                context.clear(rect)
                context.draw(imageRef, in: rect)
                var x:Int = 0
                var y:Int = 0
                let pixelCount = width*height
                var alphaPixelCount: Int = 0
                while x < width {
                    while y < height {
                        let alpha = bitmapData?.load(fromByteOffset: y*width+x, as: UInt8.self)
                        if alpha != 0 {
                            alphaPixelCount += 1
                        }
                        y += 1
                    }
                    x += 1
                }
                return Double(alphaPixelCount)/Double(pixelCount)
            }
        }
        return 0
    }
    
}
