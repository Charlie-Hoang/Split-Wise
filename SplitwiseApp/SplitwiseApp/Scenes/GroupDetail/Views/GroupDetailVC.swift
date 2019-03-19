//
//  GroupDetailVC.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/15/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class GroupDetailVC: BaseVC, SWViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newPartyButton: UIButton!
    @IBOutlet weak var totalExpenseLabel: UILabel!
    
    @IBOutlet weak var membersLabel: UILabel!
    var viewModel: GroupDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDiaryButton()
        initTableView()
        binding()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    func initTableView(){
                tableView.register(UINib(nibName: PartyCell.identifier, bundle: nil), forCellReuseIdentifier: PartyCell.identifier)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.allowsMultipleSelectionDuringEditing = false
    }
    
    func binding(){
        viewModel.output.membersText.asObservable().bind(to:self.membersLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.groupName.asObservable().bind(to: self.rx.title).disposed(by: disposeBag)
        viewModel.output.totalExpense.asObservable().bind(to: self.totalExpenseLabel.rx.text).disposed(by: disposeBag)

        newPartyButton.rx.tap.subscribe({[unowned self] value in
            self.viewModel.input.newPartyButtonSelected.onNext(true)
        }).disposed(by: disposeBag)
        viewModel.output.listParties.asObservable().bind(to:tableView.rx.items) { (tableView, row, element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: PartyCell.identifier) as! PartyCell
            cell.configCell(presenter: element)
            return cell
        }.disposed(by: disposeBag)
        tableView.rx.itemSelected.subscribe(onNext: { [unowned self] indexPath in
            self.viewModel.input.partyIndexSelected.onNext(indexPath.row)
        }).disposed(by: disposeBag)
        tableView.rx.itemDeleted.subscribe(onNext: {[unowned self] element in
            self.viewModel.input.deletePartyIndex.onNext(element.row)
        }).disposed(by: disposeBag)
    }
    func fetchData(){
        viewModel.input.fetchData.onNext(true)
    }
    @objc override func diary() {
        viewModel.input.showDiary.onNext(true)
    }
}
