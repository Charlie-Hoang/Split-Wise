//
//  NewGroupViewModel.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/15/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

protocol NewGroupViewModelInputProtocol {
    func save()
    var newMember: PublishSubject<String>{get}
    var currencySelectedIndex: Variable<Int>{get}
}
protocol NewGroupViewModelOutputProtocol {
    
    var title: Variable<String>{get}
    var description: Variable<String>{get}
    var listMembers: Variable<[String]>{get}
    var listCurrencies: Variable<[(String, String)]>{get}
    var currencyString: Variable<String>{get}
}
protocol NewGroupViewModelProtocol: SWViewModel {
    var input: NewGroupViewModelInputProtocol{get}
    var output: NewGroupViewModelOutputProtocol{get}
}
class NewGroupViewModel: NewGroupViewModelProtocol, NewGroupViewModelInputProtocol, NewGroupViewModelOutputProtocol{
    
//    var model: Group!
    var input: NewGroupViewModelInputProtocol{return self}
    var output: NewGroupViewModelOutputProtocol{return self}
    //Subjects
    
    var newMember = PublishSubject<String>()
    
    var title = Variable<String>("")
    var description = Variable<String>("")
    var listMembers = Variable<[String]>([])
    var listCurrencies = Variable<[(String, String)]>([])
    var currencySelectedIndex = Variable<Int>(0)
    var currencyString = Variable<String>("")
    
    var router: SWRouter
    var members = [Member]()
    var disposeBag = DisposeBag()
    
    //functions
    init(with router: SWRouter) {
        self.router = router
        output.listCurrencies.value = [("USD", "$"), ("VND", "đ"), ("JPY", "¥")]
        output.currencyString.value = listCurrencies.value[0].0
        binding()
    }
    func binding(){
        input.newMember.subscribe(onNext: {[unowned self] name in
            self.listMembers.value.append(name)
            self.members.append(Member(name: name))
        }).disposed(by: disposeBag)
        input.currencySelectedIndex.asObservable().subscribe(onNext:{[unowned self] index in
            self.output.currencyString.value = self.listCurrencies.value[index].0
        }).disposed(by: disposeBag)
    }
    func save() {
        let newGroup = Group()
        newGroup.name = title.value
        newGroup.des = description.value
        newGroup.currency = listCurrencies.value[currencySelectedIndex.value].1
        newGroup.members.append(objectsIn: members)
        DBService().createGroup(group: newGroup)
        self.router.enqueueRoute(with: NewGroupRouter.RouteType.save)
    }
}
