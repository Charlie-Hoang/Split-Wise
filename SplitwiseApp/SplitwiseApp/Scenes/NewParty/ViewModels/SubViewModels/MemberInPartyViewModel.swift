//
//  MemberInPartyViewModel.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/18/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation

protocol MemberInPartyPresentable {
    var name: String?{get}
    var checked: Bool?{get}
}
struct MemberInPartyViewModel: MemberInPartyPresentable{
    var model: Member
    var name: String?{return model.name}
    var checked: Bool?
    init(member: Member){
        self.model = member
        checked = true
    }
}
