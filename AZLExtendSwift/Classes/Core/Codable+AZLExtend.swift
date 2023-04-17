//
//  Codable+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2022/6/15.
//

import Foundation

/*
对codable 增加默认值支持和常用类型兼容逻辑

使用方法例子 @Default<Bool.False> var commentEnabled: Bool
参考 https://onevcat.com/2020/11/codable-default/
 */
public protocol DefaultValue {
    associatedtype Value: Codable&StringTransform&DoubleTransform
    static var defaultValue: Value { get }
}

@propertyWrapper
public struct Default<T: DefaultValue> {
    public var wrappedValue: T.Value
    
    public init(wrappedValue: T.Value) {
        self.wrappedValue = wrappedValue
    }
}


// 能通过string转换
public protocol StringTransform {
    static func convertFrom(string: String) -> Self?
}


// 能通过Double转换
public protocol DoubleTransform {
    static func convertFrom(doubleValue: Double) -> Self?
}

// 给缺失的key值也添加默认值
extension KeyedDecodingContainer {
    public func decode<T>(
        _ type: Default<T>.Type,
        forKey key: Key
    ) throws -> Default<T> where T: DefaultValue {
        try decodeIfPresent(type, forKey: key) ?? Default(wrappedValue: T.defaultValue)
    }
}

extension Default: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        // 使用默认值
        wrappedValue = T.defaultValue
        if let value = (try? container.decode(T.Value.self)) {
            wrappedValue = value
        } else {
            // 类型不对，尝试兼容类型
            //let valueType = T.Value.self
            if let stringValue = try? container.decode(String.self) {
                if let value = T.Value.convertFrom(string: stringValue) {
                    wrappedValue = value
                }
            } else if let doubleValue = try? container.decode(Double.self) {
                if let value = T.Value.convertFrom(doubleValue: doubleValue) {
                    wrappedValue = value
                }
            }
        }
    }
}

extension Default: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

// 基础类型decode默认值添加
extension Bool: StringTransform, DoubleTransform {
    public enum False: DefaultValue {
        public static let defaultValue = false
    }
    public enum True: DefaultValue {
        public static let defaultValue = true
    }
    
    public static func convertFrom(string: String) -> Bool? {
        if let value = Bool(string) {
            return value
        } else if let intValue = Int(string) {
            return intValue > 0
        }
        return nil
    }
    
    public static func convertFrom(doubleValue: Double) -> Bool? {
        return doubleValue > 0
    }
}

extension Int: StringTransform, DoubleTransform {
    
    public enum Zero: DefaultValue {
        public static let defaultValue = 0
    }
    
    public static func convertFrom(string: String) -> Int? {
        return Int(string)
    }
    
    public static func convertFrom(doubleValue: Double) -> Int? {
        return Int(doubleValue)
    }
}

extension Int64: StringTransform, DoubleTransform {
    public enum Zero: DefaultValue {
        public static let defaultValue: Int64 = 0
    }
    
    public static func convertFrom(string: String) -> Int64? {
        return Int64(string)
    }
    
    public static func convertFrom(doubleValue: Double) -> Int64? {
        return Int64(doubleValue)
    }
}

extension Double: StringTransform, DoubleTransform {
    public enum Zero: DefaultValue {
        public static let defaultValue = 0.0
    }

    public static func convertFrom(string: String) -> Double? {
        return Double(string)
    }
    
    public static func convertFrom(doubleValue: Double) -> Double? {
        return doubleValue
    }
}

extension String: StringTransform, DoubleTransform {
    public enum Empty: DefaultValue {
        public static let defaultValue = ""
    }
    
    public static func convertFrom(string: String) -> String? {
        return string
    }
    
    public static func convertFrom(doubleValue: Double) -> String? {
        let number = NSNumber.init(value: doubleValue)
        return number.stringValue
    }
}

extension Array: StringTransform, DoubleTransform {
    
    public static func convertFrom(string: String) -> Array? {
        return nil
    }
    
    public static func convertFrom(doubleValue: Double) -> Array? {
        return nil
    }
}

public extension Array where Element == String {
    enum EmptyString: DefaultValue {
        public static let defaultValue = Array<Element>()
    }
}

public extension Array where Element == Int {
    enum EmptyInt: DefaultValue {
        public static let defaultValue = Array<Element>()
    }
}

public extension Array where Element == Double {
    enum EmptyDouble: DefaultValue {
        public static let defaultValue = Array<Element>()
    }
}
