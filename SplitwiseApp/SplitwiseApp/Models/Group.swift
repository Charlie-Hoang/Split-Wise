//
//  Group.swift
//  SplitwiseCore
//
//  Created by Charlie on 3/14/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import RealmSwift

class Group: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name: String?
    @objc dynamic var des: String?
    @objc dynamic var currency: String?
    let members = List<Member>()
    let parties = List<Party>()
    
    override static func primaryKey() -> String? { return "id" }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    func membersName() -> [String]{
        return self.members.map{$0.name ?? ""}
    }
    func totalExpense() -> String{
        let total = parties.compactMap{$0.amount.value}.reduce(0, +)
        return String(format: "%@%.2f", currency ?? "", total)
    }
}
