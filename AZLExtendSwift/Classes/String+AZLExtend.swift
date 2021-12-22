//
//  String+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/8/31.
//

import Foundation
import CommonCrypto

extension String {
    /**
    计算该字符串的MD5值
    @return String md5字符串
     */
    public func azl_md5String() -> String {
        let cStrl = self.cString(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16);
        CC_MD5(cStrl, CC_LONG(strlen(cStrl!)), buffer);
        var md5String = "";
        for idx in 0...15 {
            let obcStrl = String.init(format: "%02x", buffer[idx]);
            md5String.append(obcStrl);
        }
        free(buffer);
        return md5String
    }
    
    /**
    字符串截取
    @param location 截取的开始位置
    @param length 截取的长度
    @return String 截取的字符串
    */ 
    public func azl_subString(location: Int, length: Int) -> String {
        
        if self.count >= location + length {
            let startIndex = self.index(self.startIndex, offsetBy: location)
            let endIndex = self.index(self.startIndex, offsetBy: (length + location)-1)

            let subString = self[startIndex...endIndex]

            return String(subString)
        } else {
            return self
        }
    }
    
    /**
    获取子字符串的所有位置
    @param subString 要查找的字符串
    @return [Range<String.Index>] 位置范围数组
    */ 
    public func azl_ranges(subString: String) -> [Range<String.Index>] {
        var rangeArray = [Range<String.Index>]()
        var searchedRange: Range<String.Index>
        guard let sr = self.range(of: self) else {
            return rangeArray
        }
        searchedRange = sr
        
        var resultRange = self.range(of: self, options: .regularExpression, range: searchedRange, locale: nil)
        while let range = resultRange {
            rangeArray.append(range)
            searchedRange = Range(uncheckedBounds: (range.upperBound, searchedRange.upperBound))
            resultRange = self.range(of: self, options: .regularExpression, range: searchedRange, locale: nil)
        }
        return rangeArray
    }
    
    /**
    utf8转base64
    @return String base64字符串
    */ 
    public func azl_utf8ToBase64() -> String? {
        let data = self.data(using: .utf8)
        return data?.base64EncodedString()
    }
    
    /**
    base64转utf8
    @return String utf8字符串
    */ 
    public func azl_base64ToUtf8() -> String? {
        if let data = Data.init(base64Encoded: self) {
            return String.init(data: data, encoding: .utf8)
        }
        return nil
    }
    
    /**
    ut8数据有损坏时，可用此方法去尝试解析(可能会比较耗时)
    @param data 数据
    @return String utf8字符串
    */ 
    public static func azl_forceDecodeUtf8(data: Data) -> String {
        if let string = String.init(data: data, encoding: .utf8) {
            return string
        }
        
        var resultString: String = ""
        
        var pos = 0
        let dataLength = data.count
        var stepLength = 4
        while pos != dataLength {
            if pos+stepLength > dataLength {
                stepLength = dataLength-pos
            }
            
            let subData = data.subdata(in: .init(uncheckedBounds: (lower: .init(pos), upper: .init(pos+stepLength-1))))
            if let string = String.init(data: subData, encoding: .utf8) {
                resultString += string
                pos += stepLength
                stepLength = 4
                
            }else{
                if stepLength == 1 {
                    // 把无法解析utf8的部分，用isoLatin1来解析
                    if let string = String.init(data: subData, encoding: .isoLatin1) {
                        resultString += string
                    }
                    pos += stepLength
                    stepLength = 4
                }else{
                    stepLength -= 1
                }
            }
        }
        return resultString
    }

}


