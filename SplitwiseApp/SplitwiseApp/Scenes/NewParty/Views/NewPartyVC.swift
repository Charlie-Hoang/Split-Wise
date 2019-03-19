//
//  NewPartyVC.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/18/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit

class NewPartyVC: BaseVC, SWViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var amountLabel: UITextField!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var paidByField: UITextField!
    
    var viewModel: NewPartyViewModel!
    var paidByPickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Expense"
        showSaveButton()
        initTableView()
        binding()
    }
    func initTableView(){
        tableView.register(MemberInPartyCell.self, forCellReuseIdentifier: MemberInPartyCell.identifier)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    func binding(){
        
        self.titleLabel.rx.text.orEmpty.bind(to: viewModel.output.title).disposed(by: disposeBag)
        self.amountLabel.rx.text.orEmpty.bind(to: viewModel.output.amount).disposed(by: disposeBag)
        viewModel.output.title.asObservable().bind(to: self.titleLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.amount.asObservable().bind(to: self.amountLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.currencySymbol.asObservable().bind(to: self.currencyLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.output.listMembers.asObservable().bind(to: paidByPickerView.rx.itemTitles) { _, item in
            return "\(item.name!)"
        }.disposed(by: disposeBag)
        
        
        paidByPickerView.rx.itemSelected.asObservable().subscribe(onNext: {item in
//            self.viewModel.input.paidBySelected.onNext(item.row)
            self.viewModel.input.paidBySelected.value = item.row
        }).disposed(by: disposeBag)
        

        viewModel.output.dateString.asObservable().bind(to: dateField.rx.text).disposed(by: disposeBag)
        self.dateField.rx.text.orEmpty.bind(to: viewModel.output.dateString).disposed(by: disposeBag)
        
        viewModel.output.paidBy.asObservable().bind(to: paidByField.rx.text).disposed(by: disposeBag)
        
        
        viewModel.output.listMembers.asObservable().bind(to:tableView.rx.items) { (tableView, row, element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MemberInPartyCell.identifier) as! MemberInPartyCell
            cell.configCell(presenter: element)
            return cell
        }.disposed(by: disposeBag)
        tableView.rx.itemSelected.subscribe(onNext: { [unowned self] indexPath in
            self.tableView.deselectRow(at: indexPath, animated: true)
            self.viewModel.input.memberSlected.onNext(indexPath.row)
//            self.tableView.reloadData()
            
        }).disposed(by: disposeBag)
    }
    @IBAction func selectDate(sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        viewModel.output.dateString.asObservable().subscribe(onNext:{date in
            datePickerView.setDate(date.swDate(), animated: true)
        }).disposed(by: disposeBag)
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    @IBAction func selectPaidBy(sender: UITextField) {
        
        sender.inputView = paidByPickerView
        self.paidByPickerView.selectRow(viewModel.input.paidBySelected.value, inComponent: 0, animated: true)
//        viewModel.paidBySelected.subscribe(onNext:{index in
//            self.paidByPickerView.selectRow(index, inComponent: 0, animated: true)
//        }).disposed(by: disposeBag)
    }
    @objc func handleDatePicker(sender: UIDatePicker){
        self.dateField.text = sender.date.swString()
        
    }
    @objc func handlePaidByPicker(sender: UIDatePicker){
        
    }
    @objc override func save() {
        viewModel.input.save()
    }
}
