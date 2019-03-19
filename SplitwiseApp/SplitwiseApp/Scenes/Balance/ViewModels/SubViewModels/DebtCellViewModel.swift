//
//  DebtCellViewModel.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation

protocol DebtCellPresentable {
    var creditor: String?{get}
    var debtor: String?{get}
    var amount: Double?{get}
    var currency: String?{get}
}
struct DebtCellViewModel: DebtCellPresentable{
    var model: Debt
    var creditor: String?{return model.creditor?.name}
    var debtor: String?{return model.debtor?.name}
    var amount: Double?{return model.amount}
    var currency: String?//{return model.debtor?.name}
    
    init(debt: Debt, currency: String?){
        self.model = debt
        self.currency = currency
    }
}
