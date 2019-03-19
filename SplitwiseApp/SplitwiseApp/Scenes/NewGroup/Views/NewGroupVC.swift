//
//  NewGroupVC.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/14/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit

class NewGroupVC: BaseVC, SWViewController {

    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var memberTextField: UITextField!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var addMemberButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var currencyPickerView = UIPickerView()
    var viewModel: NewGroupViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "New Group"
        showSaveButton()
        initTableView()
        binding()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleTextField.resignFirstResponder()
    }
    
    func initTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MemberCell")
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    func binding(){
        addMemberButton.rx.tap.subscribe({[unowned self] value in
            if let name = self.memberTextField.text, !name.isEmpty{
                self.viewModel.input.newMember.onNext(name)
                self.memberTextField.text = nil
            }
        }).disposed(by: disposeBag)
        viewModel.output.listMembers.asObservable().bind(to:tableView.rx.items) { (tableView, row, element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell")!
            cell.textLabel?.text = element
            return cell
        }.disposed(by: disposeBag)
        
        self.titleTextField.rx.text.orEmpty.bind(to: viewModel.output.title).disposed(by: disposeBag)
        self.descriptionTextField.rx.text.orEmpty.bind(to: viewModel.output.description).disposed(by: disposeBag)
        
        viewModel.output.listCurrencies.asObservable().bind(to: currencyPickerView.rx.itemTitles) { _, item in
            return "\(item.0)"
        }.disposed(by: disposeBag)
        
        viewModel.output.currencyString.asObservable().bind(to: currencyTextField.rx.text).disposed(by: disposeBag)
        
        currencyPickerView.rx.itemSelected.asObservable().subscribe(onNext: {item in
            self.viewModel.input.currencySelectedIndex.value = item.row
        }).disposed(by: disposeBag)
        
    }
    @IBAction func selectCurrency(sender: UITextField) {
        
        sender.inputView = currencyPickerView
        currencyPickerView.selectRow(viewModel.input.currencySelectedIndex.value, inComponent: 0, animated: true)
    }
    @objc override func save() {
        viewModel.input.save()
    }
}
