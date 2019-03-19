//
//  HomeCell.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/14/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell, CellConfigurable {
    typealias Presenter = GroupCellPresentable
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(presenter: Presenter){
        titleLabel.text = presenter.name
        descriptionLabel.text = presenter.des
        
    }
    
}
