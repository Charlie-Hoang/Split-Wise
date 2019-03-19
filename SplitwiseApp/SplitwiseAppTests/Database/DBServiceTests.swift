//
//  DBServiceTests.swift
//  SplitwiseAppTests
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import XCTest
@testable import SplitwiseApp

class DBServiceTests: XCTestCase {
    var group: Group!
    let dbService = DBService(config: DBInMemoryConfiguration.default)
    override func setUp() {
        
        
    }
    func initDB(){
        group = Group(name: "9A")
        group.des = "lop cap 2"
        let m1 = Member(name: "cuong")
        let m2 = Member(name: "an")
        let m3 = Member(name: "binh")
        group.members.append(objectsIn: [m1, m2, m3])
        let p1 = Party(title: "sinh nhat Cuong")
        p1.amount.value = 300
        p1.paidBy = m1
        p1.members.append(objectsIn: [m1, m2, m3])
        let p2 = Party(title: "nha moi An")
        p2.amount.value = 600
        p2.paidBy = m2
        p2.members.append(objectsIn: [m1, m2, m3])
        group.parties.append(objectsIn: [p1, p2])
        dbService.createGroup(group: group)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testGroup() {
        dbService.deleteAllGroups()
        initDB()
        let groups = dbService.fetchGroups()
        XCTAssert(groups.count==1, "should be 1 group")
        
        XCTAssert(groups.first?.name == "9A", "should be equals")
        XCTAssert(groups.first?.des == "lop cap 2", "should be equals")
        XCTAssert(groups.first?.members.count == 3, "members of group should be 3")
        
    }
    func testUpdateGroup(){
        dbService.deleteAllGroups()
        initDB()
        let groups = dbService.fetchGroups()
        let group = groups[0]
        dbService.update(group: group) {
            group.name = "12A"
        }
        let newGroups = dbService.fetchGroups()
        XCTAssert(newGroups.first?.name=="12A", "new group should be named 12A")
        dbService.deleteAllGroups()
    }
    func testDeleteGroup(){
        initDB()
        dbService.deleteAllGroups()
        let groups = dbService.fetchGroups()
        XCTAssert(groups.count==0, "group should be empty")
    }
    func testDeleteParty(){
        dbService.deleteAllGroups()
        initDB()
        let groups = dbService.fetchGroups()
        let party = groups.first?.parties.first
        dbService.deleteParty(party: party!)
        let groupNow = dbService.fetchGroups()
        XCTAssert(groupNow.first?.parties.count == 1, "parties count should be 1")
    }
    func testMember(){
        
    }
}
