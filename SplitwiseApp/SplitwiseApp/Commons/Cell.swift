//
//  Cell.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/14/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation

//base protocol
protocol CellPresentable {
    
}


protocol CellConfigurable {
    associatedtype Presenter
    func configCell(presenter: Presenter)
}
