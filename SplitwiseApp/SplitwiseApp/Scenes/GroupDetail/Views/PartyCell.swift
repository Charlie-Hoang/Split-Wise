//
//  PartyCell.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/18/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit

class PartyCell: UITableViewCell, CellConfigurable {

    typealias Presenter = PartyCellPresentable
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var paidByLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(presenter: Presenter){
        titleLabel.text = presenter.title
        amountLabel.text = String(format: "%@%.2f", presenter.currency ?? "", presenter.amount ?? 0)
        paidByLabel.text = presenter.paidBy
        dateLabel.text = presenter.date?.swString()
    }
    
}
