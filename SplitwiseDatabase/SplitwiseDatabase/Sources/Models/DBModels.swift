//
//  DBModels.swift
//  SplitwiseCore
//
//  Created by Charlie on 3/14/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

class DBGroup: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name: String?
    @objc dynamic var des: String?
    let members = List<DBMember>()
    
    override static func primaryKey() -> String? { return "id" }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    convenience init(group: Group){
        self.init()
        self.name = group.name
        self.shortDescription = group.description
        
        guard let members = group.members else{return}
        for member in members{
            self.members.append(DBMember(member: member))
        }
    }
}

class DBMember: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name: String?
    
    override static func primaryKey() -> String? { return "id" }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    convenience init(member: Member){
        self.init()
        self.name = member.name
    }
}

class DBParty: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title: String?
    @objc dynamic var date: Date?
    @objc dynamic var currency: String?
    let amount = RealmOptional<Double>()
    let members = List<DBMember>()
    
    override static func primaryKey() -> String? { return "id" }
    
    convenience init(title: String){
        self.init()
        self.title = title
    }
    convenience init(party: Party){
        self.init()
        self.title = party.title
        self.date = party.date
        self.currency = party.currency
        self.amount.value = party.amount
        
        guard let members = party.members else{return}
        for member in members{
            self.members.append(DBMember(member: member))
        }
    }
}
