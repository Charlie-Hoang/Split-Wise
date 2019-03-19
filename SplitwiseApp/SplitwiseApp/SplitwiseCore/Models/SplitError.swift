//
//  SplitError.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
public enum SplitError: Error {
    
    case emptyExpense
    case emptyDebt
    case invalid
    
    /// Error message
    public var errorMessage: String {
        switch self {
        case .emptyExpense:
            return "There is no Expense"
        case .emptyDebt:
            return "There is no Debt"
        case .invalid:
            return "Invalid"
        }
    }
}
