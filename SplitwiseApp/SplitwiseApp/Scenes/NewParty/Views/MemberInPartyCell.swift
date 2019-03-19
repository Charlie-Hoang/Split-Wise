//
//  MemberInPartyCell.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/18/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit

class MemberInPartyCell: UITableViewCell, CellConfigurable {
    typealias Presenter = MemberInPartyPresentable
    
    func configCell(presenter: Presenter){
        self.textLabel?.text = presenter.name
        self.accessoryType = presenter.checked! ? .checkmark : .none

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
