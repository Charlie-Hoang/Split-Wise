//
//  SplitwiseServiceTests.swift
//  SplitwiseAppTests
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import XCTest
@testable import SplitwiseApp

class SplitwiseServiceTests: XCTestCase {
    
    func testGetExpenseDiary(){
        let group = Group()
        let cuong = Member(name: "Cuong")
        let an = Member(name: "An")
        let binh = Member(name: "Binh")
        let party = Party(title: "sinh nhat")
        party.members.append(objectsIn: [cuong, an, binh])
        party.amount.value = 30
        party.paidBy = cuong
        group.parties.append(party)
        group.members.append(objectsIn: [cuong, an, binh])
        let split = SplitwiseService(group: group)
        let result = split.getExpenseDiary(member: cuong)
        switch result {
        case .success(let diaries, let amount):
            XCTAssert(amount == 20, "total amout should be $10!")
            XCTAssert(diaries.count == 1, "total parties should be 1!")
            XCTAssert(diaries.first?.amount == 20, "amout of first party should be 10!")
        case .failed(_):
            XCTAssert(false, "split should be succeeded!")
        }
        
        let result2 = split.getExpenseDiary(member: an)
        switch result2 {
        case .success(let diaries, let amount):
            XCTAssert(amount == -10, "total amout should be $10!")
            XCTAssert(diaries.count == 1, "total parties should be 1!")
            XCTAssert(diaries.first?.amount == -10, "amout of first party should be 10!")
        case .failed(_):
            XCTAssert(false, "split should be succeeded!")
        }
        
        let result3 = split.getExpenseDiary(member: binh)
        switch result3 {
        case .success(let diaries, let amount):
            XCTAssert(amount == -10, "total amout should be $10!")
            XCTAssert(diaries.count == 1, "total parties should be 1!")
            XCTAssert(diaries.first?.amount == -10, "amout of first party should be 10!")
        case .failed(_):
            XCTAssert(false, "split should be succeeded!")
        }
    }
    func testGetDebts() {
        let group = Group()
        let cuong = Member(name: "Cuong")
        let an = Member(name: "An")
        let party = Party(title: "sinh nhat")
        party.members.append(objectsIn: [cuong, an])
        party.amount.value = 10
        party.paidBy = cuong
        group.parties.append(party)
        group.members.append(objectsIn: [cuong, an])
        let split = SplitwiseService(group: group)
        let result = split.getDebts()
        switch result {
        case .success(let debts):
        
            XCTAssert(debts.first?.creditor?.name == "Cuong", "creditor should be Cuong")
            XCTAssert(debts.first?.debtor?.name == "An", "debtor should be An")
            XCTAssert(debts.first?.amount == 5, "owe amout should be $5")
        case .failed(_):
            XCTAssert(false, "split should be succeeded!")
        }
    }

}
