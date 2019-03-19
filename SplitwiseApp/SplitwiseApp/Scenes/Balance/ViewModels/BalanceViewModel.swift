//
//  BalanceViewModel.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol BalanceViewModelInputProtocol {
    
}
protocol BalanceViewModelOutputProtocol {
    var listDebts: Variable<[DebtCellViewModel]>{get}
}
protocol BalanceViewModelProtocol: SWViewModel {
    var input: BalanceViewModelInputProtocol{get}
    var output: BalanceViewModelOutputProtocol{get}
}
class BalanceViewModel: BalanceViewModelProtocol, BalanceViewModelInputProtocol, BalanceViewModelOutputProtocol{
    
    var input: BalanceViewModelInputProtocol{return self}
    var output: BalanceViewModelOutputProtocol{return self}
    //Subjects
    var listDebts = Variable<[DebtCellViewModel]>([])
    
    var disposeBag = DisposeBag()
    
    var router: SWRouter
    var group: Group
    //functions
    init(with router: SWRouter, group: Group) {
        self.router = router
        self.group = group
        binding()
        
        getDebts()
    }
    func binding(){
        
    }
    func getDebts(){
        let split = SplitwiseService(group: self.group)
        let result = split.getDebts()
        switch result{
        case .success(let debts):
            self.output.listDebts.value = debts.map{DebtCellViewModel(debt: $0, currency: self.group.currency)}
        case .failed(let error):
            print(error.errorMessage)
        }
    }
}
