//
//  Data+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/12/29.
//

import Foundation

extension Data {

    /**
    获取数据的16进制字符串
    @return String 16进制字符串
     */
    func azl_hexString() -> String {
        return self.map { intValue in
            String(format: "%02x", intValue)
        }.joined(separator: "")
    }
}
