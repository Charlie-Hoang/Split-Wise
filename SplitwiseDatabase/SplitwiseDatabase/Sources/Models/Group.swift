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
    let members = List<Member>()
    
    override static func primaryKey() -> String? { return "id" }
    
    convenience init(name: String) {
        self.init()
        self.name = name
        
    }
}
