//
//  DiaryResult.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation

enum DiaryResult{
    typealias T = [Expense]
    case success(T, Double)
    case failed(SplitError)
}

enum DebtResult{
    typealias T = [Debt]
    case success(T)
    case failed(SplitError)
}
