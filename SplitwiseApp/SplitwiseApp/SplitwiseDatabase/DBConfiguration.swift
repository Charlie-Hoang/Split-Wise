//
//  DBConfiguration.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import RealmSwift
//configuration for DBService
protocol DBConfigurable {
    var realm: Realm{get}
}

struct DBConfiguration: DBConfigurable {
    var realm = try! Realm()
}
