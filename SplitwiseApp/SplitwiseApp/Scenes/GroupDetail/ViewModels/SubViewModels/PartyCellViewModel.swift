//
//  PartyCellViewModel.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/18/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation

protocol PartyCellPresentable {
    var title: String?{get}
    var amount: Double?{get}
    var currency: String?{get}
    var paidBy: String?{get}
    var date: Date?{get}
}
struct PartyCellViewModel: PartyCellPresentable{
    var model: Party
    var title: String?{return model.title}
    var amount: Double?{return model.amount.value}
    var currency: String?//{return model}
    var paidBy: String?{return model.paidBy?.name}
    var date: Date?{return model.date}
    init(party: Party, currency: String?){
        self.model = party
        self.currency = currency
    }
}
