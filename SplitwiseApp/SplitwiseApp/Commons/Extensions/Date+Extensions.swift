//
//  Date+Extensions.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/18/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import UIKit

extension Date{
    func swString() -> String?{
        let formater = DateFormatter()
        formater.dateFormat = "dd/MM/yyyy"
        return formater.string(from: self)
    }
}

extension String{
    func swDate() -> Date{
        let formater = DateFormatter()
        formater.dateFormat = "dd/MM/yyyy"
        return formater.date(from: self) ?? Date()
    }
}

