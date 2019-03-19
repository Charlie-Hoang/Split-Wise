//
//  ExpenseCellViewModel.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation

protocol ExpenseCellPresentable {
    var member: String?{get}
    var amount: Double?{get}
    var currency: String?{get}
    var party: String?{get}
    var date: Date?{get}
}
struct ExpenseCellViewModel: ExpenseCellPresentable{
    var model: Expense
    var member: String?{return model.member?.name}
    var amount: Double?{return model.amount}
    var currency: String?//{return model.member?.name}
    var party: String?{return model.party?.title}
    var date: Date?{return model.party?.date}
    init(expense: Expense, currency: String?){
        self.model = expense
        self.currency = currency
    }
}
