//
//  BalaceVC.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit

class BalaceVC: BaseVC, SWViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: BalanceViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Balance"
        initTableView()
        binding()
    }
    func initTableView(){
        tableView.register(UINib(nibName: DebtCell.identifier, bundle: nil), forCellReuseIdentifier: DebtCell.identifier)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func binding(){
        viewModel.output.listDebts.asObservable().bind(to:tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: DebtCell.identifier) as! DebtCell
            cell.configCell(presenter: element)
            return cell
            }.disposed(by: disposeBag)
    }

}
