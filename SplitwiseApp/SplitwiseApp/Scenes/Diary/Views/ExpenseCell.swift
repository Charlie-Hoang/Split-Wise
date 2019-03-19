//
//  ExpenseCell.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit

class ExpenseCell: UITableViewCell, CellConfigurable {

    typealias Presenter = ExpenseCellPresentable
    
    @IBOutlet weak var memberNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var partyNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    func configCell(presenter: Presenter){
        memberNameLabel.text = presenter.member
        amountLabel.text = String(format: "%@%.2f", presenter.currency ?? "", presenter.amount ?? 0)
        partyNameLabel.text = presenter.party
        dateLabel.text = presenter.date?.swString()
    }
    
}
