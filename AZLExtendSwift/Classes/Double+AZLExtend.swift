//
//  Double+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/10/14.
//

import Foundation

extension Double {
    /// 拆分为时分秒
    public func azl_timeData() -> (hour: Int, minute: Int, second: Int) {
        let intValue = Int(self)
        return intValue.azl_timeData()
    }
}
