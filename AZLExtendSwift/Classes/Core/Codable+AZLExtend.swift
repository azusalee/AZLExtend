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
    associatedtype Value: Codable
    static var defaultValue: Value { get }
}

@propertyWrapper
public struct Default<T: DefaultValue> {
    public var wrappedValue: T.Value
    
    public init(wrappedValue: T.Value) {
        self.wrappedValue = wrappedValue
    }
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
            let valueType = T.Value.self
            if valueType == String.self, let doubleValue = try? container.decode(Double.self) {
                let number = NSNumber.init(value: doubleValue)
                wrappedValue = number.stringValue as! T.Value
            } else if let stringValue = try? container.decode(String.self) {
                if valueType == Double.self, let value = Double(stringValue) as? T.Value {
                    wrappedValue = value
                } else if valueType == Int.self, let value = Int(stringValue) as? T.Value {
                    wrappedValue = value
                } else if valueType == Bool.self {
                    if let value = Bool(stringValue) as? T.Value {
                        wrappedValue = value
                    } else if let intValue = Int(stringValue) {
                        if intValue > 0 {
                            wrappedValue = true as! T.Value
                        } else {
                            wrappedValue = false as! T.Value
                        }
                    }
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
public extension Bool {
    enum False: DefaultValue {
        public static let defaultValue = false
    }
    enum True: DefaultValue {
        public static let defaultValue = true
    }
}

public extension Int {
    enum Zero: DefaultValue {
        public static let defaultValue = 0
    }
}

public extension Double {
    enum Zero: DefaultValue {
        public static let defaultValue = 0.0
    }
}

public extension String {
    enum Empty: DefaultValue {
        public static let defaultValue = ""
    }
}
