//
//  SplitwiseDatabase.swift
//  SplitwiseCore
//
//  Created by Charlie on 3/15/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import RealmSwift
//Protocol
protocol DBServiceProtocol{
    var configuration: DBConfigurable{get}
}
//Service
struct DBService{
    private var database: Realm!
    private var configuration: DBConfigurable
    public init(config: DBConfigurable) {
        self.configuration = config
        self.database = config.realm
    }
    init(){
        self.configuration = DBConfiguration()
        self.database = self.configuration.realm
    }
}

extension DBService{
    func createGroup(group: Group){
        try! database.write{
            database.add(group, update: true)
        }
    }
    func fetchGroups() -> Results<Group>{
        return database.objects(Group.self)
    }
    func fetchGroup(id: String) -> Group?{
        return database.object(ofType: Group.self, forPrimaryKey: id)
    }
    func deleteGroup(group: Group){
        try! database.write {
            for member in group.members{
                database.delete(member)
            }
            for party in group.parties{
                database.delete(party)
            }
            database.delete(group)
        }
    }
    func deleteParty(party: Party){
        try! database.write {
            database.delete(party)
        }
    }
    func deleteAllGroups(){
        let groups = database.objects(Group.self)
        if !groups.isEmpty{
            try! database.write{
                database.delete(groups)
            }
        }
    }
    func update(group: Group, block: ()->()){
        try! database.write{
            block()
            database.add(group, update: true)
        }
    }
}
