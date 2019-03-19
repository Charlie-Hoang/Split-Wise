//
//  HomeVC.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/14/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit
//import SplitwiseCore

class HomeVC: BaseVC, SWViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newGroupButton: UIButton!
    
    var viewModel: HomeViewModel!
//    var dataSource = HomeDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Splitwise"
        initTableView()
        binding()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    func initTableView(){
        tableView.register(UINib(nibName: HomeCell.identifier, bundle: nil), forCellReuseIdentifier: HomeCell.identifier)
//        tableView.dataSource = dataSource
//        tableView.delegate = dataSource
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.allowsMultipleSelectionDuringEditing = false
//        tableView.rx.setDataSource(<#T##dataSource: UITableViewDataSource##UITableViewDataSource#>)(self)
//            .addDisposableTo(disposeBag)
    }
    func binding(){
        viewModel.output.listGroups.asObservable().bind(to:tableView.rx.items) { (tableView, row, element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier) as! HomeCell
            cell.configCell(presenter: element)
            return cell
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [unowned self] indexPath in
            
            self.viewModel.input.groupIndexSelected.onNext(indexPath.row)
            
        }).disposed(by: disposeBag)
        
        tableView.rx.itemDeleted.subscribe(onNext: {[unowned self] element in
                self.viewModel.input.deleteGroupIndex.onNext(element.row)
        }).disposed(by: disposeBag)
        
        newGroupButton.rx.tap.subscribe({[unowned self] value in
//            self.viewModel.input.createNewGroup()
            self.viewModel.input.newGroupButtonSelected.onNext(true)
        }).disposed(by: disposeBag)
    }
    func fetchData(){
        viewModel.input.fetchGroups.onNext(true)
    }
}
