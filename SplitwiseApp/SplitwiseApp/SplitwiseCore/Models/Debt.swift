//
//  Debt.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation

class Debt {
    var creditor: Member?
    var debtor: Member?
    var amount: Double?
    init(creditor: Member, debtor: Member, amount: Double){
        self.creditor = creditor
        self.debtor = debtor
        self.amount = amount
    }
}
