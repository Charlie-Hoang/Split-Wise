//
//  GroupViewModel.swift
//  SplitwiseDatabase
//
//  Created by Charlie on 3/15/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation

protocol GroupPresentable {
    var name: String?{get}
    var des: String?{get}
}
struct GroupViewModel: GroupPresentable{
    var model: Group
    var name: String?{return model.name}
    var des: String?{return model.des}
    init(group: Group){
        self.model = group
    }
}
