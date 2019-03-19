//
//  GroupTests.swift
//  SplitwiseAppTests
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import XCTest
@testable import SplitwiseApp

class GroupTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testMembersName() {
        let group = Group(name: "9A")
        let mem1 = Member(name: "Charlie")
        let mem2 = Member(name: "John")
        let mem3 = Member(name: "Bin")
        group.members.append(objectsIn: [mem1, mem2, mem3])
        XCTAssert(group.membersName() == ["Charlie", "John", "Bin"], "members name should be equal with respect!")
    }
    func testTotalExpense(){
        let group = Group(name: "9A")
        let mem1 = Member(name: "Charlie")
        let mem2 = Member(name: "John")
        let mem3 = Member(name: "Bin")
        group.members.append(objectsIn: [mem1, mem2, mem3])
        let party1 = Party(title: "sinh nhat Charlie")
        party1.amount.value = 300
        party1.members.append(objectsIn: [mem1, mem2, mem3])
        let party2 = Party(title: "sinh nhat Charlie")
        party2.amount.value = 50
        party2.members.append(objectsIn: [mem1, mem2])
        group.currency = "$"
        group.parties.append(objectsIn: [party1, party2])
        XCTAssert(group.totalExpense() == "$350.00", "Total expense shoule be 300")
    }

}
