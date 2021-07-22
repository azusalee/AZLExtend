//
//  BTSMapManager.swift
//  tasker
//
//  Created by yangming on 2019/1/21.
//  Copyright © 2019年 BT. All rights reserved.
//

import UIKit
import Accelerate

public extension UIImage {

    /// 从url生成缩略图(指定大小)
    class func azl_imageFrom(url:URL, size:CGSize) -> UIImage? {
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
    class func azl_imageFrom(data:Data, size:CGSize) -> UIImage? {
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
    class func azl_imageFrom(color:UIColor, size:CGSize = CGSize.init(width: 1, height: 1)) -> UIImage? {
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
    class func azl_imageFrom(view:UIView) -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, scale)
        var image:UIImage?
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// 预解压
    class func azl_preDecode(cgImage:CGImage) -> CGImage? {
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
    
    
    // 实例方法
    
    /// 把图片缩放到指定size
    func azl_scaleImage(size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size))
        let scaleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaleImage
    }
    
    /// 根据宽等比缩放
    func azl_scaleImage(width:CGFloat) -> UIImage? {
        if self.size.width == 0 || self.size.height == 0 {
            return nil
        }
        let height = width*(self.size.height/self.size.width)
        return self.azl_scaleImage(size: CGSize.init(width: width, height: height))
    }
    
    /// 根据高等比缩放
    func azl_scaleImage(height:CGFloat) -> UIImage? {
        if self.size.width == 0 || self.size.height == 0 {
            return nil
        }
        let width = height*(self.size.width/self.size.height)
        return self.azl_scaleImage(size: CGSize.init(width: width, height: height))
    }
    
    /// 裁剪图片
    func azl_clipImage(rect:CGRect) -> UIImage? {
        if let subImage = self.cgImage?.cropping(to: rect) {
            return UIImage(cgImage: subImage)
        }
        return nil
    }
    
    /// 内切圆裁剪
    func azl_clipCircleImage(rect:CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        
        context?.addEllipse(in: rect)
        context?.clip()
        self.draw(at: CGPoint.init(x: -rect.origin.x, y: -rect.origin.y))
        let clipImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return clipImage
    }
    
    /// 圆裁剪
    func azl_clipCircleImage(point:CGPoint, radius:CGFloat) -> UIImage? {
        let rect = CGRect.init(x: point.x-radius, y: point.y-radius, width: radius*2, height: radius*2)
        return self.azl_clipImage(rect: rect)
    }
    
    /// 灰度图
    func azl_grayImage() -> UIImage? {
        let width:Int = Int(self.size.width*self.scale)
        let height:Int = Int(self.size.height*self.scale)
        
        let colorSpace = CGColorSpaceCreateDeviceGray()
        if let context = CGContext.init(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue), let oriCGImage = self.cgImage {
            context.draw(oriCGImage, in: CGRect.init(x: 0, y: 0, width: width, height: height))
            if let cgImage = context.makeImage() {
                let grayImage = UIImage.init(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
                return grayImage
            }
        }
        
        return nil
    }
    
    /// 灰度渐隐
    func azl_grayAlphaImage() -> UIImage? {
        if let imageRef = self.cgImage {
            let width = imageRef.width
            let height = imageRef.height
            let bitmapData = malloc(1*width*height*8)
            
            if let context = CGContext.init(data: bitmapData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 32, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {
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
                        let r = bitmapData?.load(fromByteOffset: index*4, as: Int8.self) ?? 0
                        let g = bitmapData?.load(fromByteOffset: index*4+1, as: Int8.self) ?? 0
                        let b = bitmapData?.load(fromByteOffset: index*4+2, as: Int8.self) ?? 0
                        
                        var gray = Double(r) * 0.2126
                        gray += Double(g) * 0.7152 + Double(b) * 0.0722
                        if gray > 255 {
                            gray = 255
                        }
                        let grayInt = Int8(gray)
                        
                        // 替换每一点的rgba
                        bitmapData?.storeBytes(of: grayInt, toByteOffset: index*4, as: Int8.self)
                        bitmapData?.storeBytes(of: grayInt, toByteOffset: index*4+1, as: Int8.self)
                        bitmapData?.storeBytes(of: grayInt, toByteOffset: index*4+2, as: Int8.self)
                        bitmapData?.storeBytes(of: grayInt, toByteOffset: index*4+3, as: Int8.self)
                        
                        j += 1
                    }
                    i += 1
                }
                
                if let cgImage = context.makeImage() {
                    return UIImage.init(cgImage: cgImage)
                }
            }
        }
        return nil
    }
    
    func azl_boxBlurImage(blur:CGFloat) {
        var fixBlur = blur
        if blur < 0 || blur > 1 {
            fixBlur = 0.5
        }
        
        var boxSize:Int = Int(fixBlur*50)
        boxSize = boxSize - (boxSize % 2) + 1
        if let img = self.cgImage {
            var inBuffer:vImage_Buffer = vImage_Buffer()
            var outBuffer:vImage_Buffer = vImage_Buffer()
            
            if let inProvider = img.dataProvider {
                let inBitmapData = inProvider.data
                inBuffer.width = vImagePixelCount(img.width)
                inBuffer.height = vImagePixelCount(img.height)
                
            }
        }
    }
    
}
