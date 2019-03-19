//
//  Number+Extensions.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation

extension Double{
    static func ==(left: Double, right: Double) -> Bool {
        if fabs(left - right)<0.0001{
            return true
        }
        return false
    }
}
