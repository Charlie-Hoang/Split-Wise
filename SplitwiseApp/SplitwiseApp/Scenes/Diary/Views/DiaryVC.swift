//
//  DiaryVC.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit

class DiaryVC: BaseVC, SWViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var memberField: UITextField!
    
    var memberPickerView = UIPickerView()
    
    var viewModel: DiaryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Diary"
        showBalanceButton()
        initTableView()
        binding()
    }
    func initTableView(){
        tableView.register(UINib(nibName: ExpenseCell.identifier, bundle: nil), forCellReuseIdentifier: ExpenseCell.identifier)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func binding(){
        viewModel.output.memberSelectedString.asObservable().bind(to: self.memberField.rx.text).disposed(by: disposeBag)
//        self.memberField.rx.text.orEmpty.bind(to: viewModel.output.memberSelectedString).disposed(by: disposeBag)
//        viewModel.output.memberSelectedString.subscribe(onNext:{str in
//            self.memberField.text = str
//        }).disposed(by: disposeBag)
        viewModel.output.listMembers.asObservable().bind(to: memberPickerView.rx.itemTitles) { _, item in
            return "\(item.name!)"
        }.disposed(by: disposeBag)
        
        memberPickerView.rx.itemSelected.asObservable().subscribe(onNext: {item in
            self.viewModel.memberSelectedIndex.onNext(item.row)
        }).disposed(by: disposeBag)
        
        viewModel.output.listExpenses.asObservable().bind(to:tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: ExpenseCell.identifier) as! ExpenseCell
            cell.configCell(presenter: element)
            return cell
        }.disposed(by: disposeBag)
    }
    @IBAction func selectMember(sender: UITextField) {
        
        sender.inputView = memberPickerView
//        viewModel.memberSelectedIndex.asObservable().subscribe(onNext:{index in
//            self.memberPickerView.selectRow(index, inComponent: 0, animated: true)
//        }).disposed(by: disposeBag)
    }
    @objc override func balance() {
        viewModel.input.showBalance.onNext(true)
    }
}
