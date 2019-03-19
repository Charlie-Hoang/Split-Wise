//
//  Expense.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation

class Expense {
    var member: Member?
    var party: Party?
    var amount: Double?
    init(member: Member){
        self.member = member
    }
}
