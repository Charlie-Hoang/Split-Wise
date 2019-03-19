//
//  Member.swift
//  SplitwiseCore
//
//  Created by Charlie on 3/14/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import RealmSwift

class Member: Object{
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name: String?
    
    override static func primaryKey() -> String? { return "id" }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
