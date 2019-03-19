//
//  DebtCell.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit

class DebtCell: UITableViewCell, CellConfigurable {

    typealias Presenter = DebtCellPresentable
    
    @IBOutlet weak var creditorLabel: UILabel!
    @IBOutlet weak var debtorLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    func configCell(presenter: Presenter){
        creditorLabel.text = presenter.creditor
        debtorLabel.text = presenter.debtor
        amountLabel.text = String(format: "%@%.2f", presenter.currency ?? "", presenter.amount ?? 0)
    }
    
}
