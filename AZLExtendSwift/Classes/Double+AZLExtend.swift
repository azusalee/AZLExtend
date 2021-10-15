//
//  Double+AZLExtend.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/10/14.
//

import Foundation

extension Double {
    func azl_timeData() -> (hour: Int, minute: Int, second: Int) {
        let intValue = Int(self)
        return intValue.azl_timeData()
    }
}
