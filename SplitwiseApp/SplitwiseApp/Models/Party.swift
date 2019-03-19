//
//  Party.swift
//  SplitwiseCore
//
//  Created by Charlie on 3/14/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import RealmSwift

class Party: Object{
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title: String?
    @objc dynamic var date: Date?
    @objc dynamic var currency: String?
    @objc dynamic var paidBy: Member?
    let amount = RealmOptional<Double>()
    let members = List<Member>()
    
    override static func primaryKey() -> String? { return "id" }
    
    convenience init(title: String){
        self.init()
        self.title = title
    }
}
