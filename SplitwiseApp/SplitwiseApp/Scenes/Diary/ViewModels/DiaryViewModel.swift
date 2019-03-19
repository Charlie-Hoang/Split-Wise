//
//  DiaryViewModel.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol DiaryViewModelInputProtocol {
    var memberSelectedIndex: PublishSubject<Int>{get}
    var memberForExpenses: PublishSubject<Member>{get}
    var showBalance: PublishSubject<Bool>{get}
}
protocol DiaryViewModelOutputProtocol {
    var listExpenses: Variable<[ExpenseCellViewModel]>{get}
    var listMembers: Variable<[MemberInPartyViewModel]>{get}
    var memberSelectedString: Variable<String>{get}
}
protocol DiaryViewModelProtocol: SWViewModel {
    var input: DiaryViewModelInputProtocol{get}
    var output: DiaryViewModelOutputProtocol{get}
}
class DiaryViewModel: DiaryViewModelProtocol, DiaryViewModelInputProtocol, DiaryViewModelOutputProtocol{
    
    //    var model: Group!
    var input: DiaryViewModelInputProtocol{return self}
    var output: DiaryViewModelOutputProtocol{return self}
    //Subjects
    var memberForExpenses = PublishSubject<Member>()
    var listExpenses = Variable<[ExpenseCellViewModel]>([])
    var memberSelectedIndex = PublishSubject<Int>()
    var memberSelectedString = Variable<String>("")
    var listMembers = Variable<[MemberInPartyViewModel]>([])
    var showBalance = PublishSubject<Bool>()
    
    var disposeBag = DisposeBag()
    
    var router: SWRouter
    var group: Group
    //functions
    init(with router: SWRouter, group: Group) {
        self.router = router
        self.group = group
        binding()
        memberSelectedIndex.onNext(0)
    }
    func binding(){
        output.listMembers.value = group.members.map{MemberInPartyViewModel(member: $0)}
        memberForExpenses.subscribe(onNext:{member in
            let split = SplitwiseService(group: self.group)
            let result = split.getExpenseDiary(member: member)
            switch result{
            case .success(let expenses, _):
                self.output.listExpenses.value = expenses.map{ExpenseCellViewModel(expense: $0, currency: self.group.currency)}
                print(expenses)
            case .failed(let error):
                self.output.listExpenses.value = []
                print(error.errorMessage)
            }
            
        }).disposed(by: disposeBag)
        memberSelectedIndex.subscribe(onNext:{index in
            let member = self.group.members[index]
            self.output.memberSelectedString.value = member.name ?? ""
            self.memberForExpenses.onNext(member)
        }).disposed(by: disposeBag)
        input.showBalance.subscribe(onNext: {[unowned self] value in
            if value{
                self.router.enqueueRoute(with: DiaryRouter.RouteType.goBalance(self.group))
            }
        }).disposed(by: disposeBag)
    }
    
}
