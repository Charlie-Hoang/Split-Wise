//
//  DBInMemoryConfiguration.swift
//  SplitwiseAppTests
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import RealmSwift

@testable import SplitwiseApp
func realmInMemory(_ name: String = UUID().uuidString) -> Realm {
    var conf = Realm.Configuration()
    conf.inMemoryIdentifier = name
    return try! Realm(configuration: conf)
}
struct DBInMemoryConfiguration: DBConfigurable {
    var realm = realmInMemory(#function)
    static let `default` = DBInMemoryConfiguration()
}
