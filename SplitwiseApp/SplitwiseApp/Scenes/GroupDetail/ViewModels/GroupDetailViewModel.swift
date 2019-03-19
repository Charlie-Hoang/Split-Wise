//
//  GroupDetailViewModel.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/18/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

protocol GroupDetailViewModelInputProtocol {
    var fetchData: PublishSubject<Bool>{get}
    var newPartyButtonSelected: PublishSubject<Bool>{get}
    var partyIndexSelected: PublishSubject<Int>{get}
    var showDiary: PublishSubject<Bool>{get}
    var deletePartyIndex: PublishSubject<Int>{get}
}
protocol GroupDetailViewModelOutputProtocol {
    var groupName: Variable<String>{get}
    var membersText: Variable<String>{get}
    var listParties: Variable<[PartyCellViewModel]>{get}
    var totalExpense: Variable<String>{get}
}
protocol GroupDetailViewModelProtocol: SWViewModel {
    var input: GroupDetailViewModelInputProtocol{get}
    var output: GroupDetailViewModelOutputProtocol{get}
}
class GroupDetailViewModel: GroupDetailViewModelProtocol, GroupDetailViewModelInputProtocol, GroupDetailViewModelOutputProtocol{
    
    var input: GroupDetailViewModelInputProtocol{return self}
    var output: GroupDetailViewModelOutputProtocol{return self}
    
    var groupName = Variable<String>("")
    var membersText = Variable<String>("")
    var newPartyButtonSelected = PublishSubject<Bool>()
    var listParties = Variable<[PartyCellViewModel]>([])
    var fetchData = PublishSubject<Bool>()
    var totalExpense = Variable<String>("")
    var partyIndexSelected = PublishSubject<Int>()
    var showDiary = PublishSubject<Bool>()
    var deletePartyIndex = PublishSubject<Int>()
    
    var groupId: String
    var group: Group!
    var router: SWRouter
    
    private let disposeBag = DisposeBag()
    
    init(with router: SWRouter, groupId: String) {
        self.router = router
        self.groupId = groupId
        binding()
        input.fetchData.onNext(true)
//        output.membersText.value = group.membersName().joined(separator: ", ")
//        output.listParties.value = group.parties.map{PartyCellViewModel(party: $0)}
        
    }
    func binding(){
        input.newPartyButtonSelected.subscribe(onNext: {[unowned self] value in
            if value{
                self.router.enqueueRoute(with: GroupDetailRouter.RouteType.newParty(self.group!))
            }
        }).disposed(by: disposeBag)
        fetchData.subscribe(onNext: {[unowned self] value in
            if value, let group = DBService().fetchGroup(id: self.groupId){
                self.group = group
                self.output.groupName.value = group.name ?? ""
                self.output.membersText.value = group.membersName().joined(separator: ", ")
                self.output.listParties.value = group.parties.map{PartyCellViewModel(party: $0, currency: group.currency)}
                self.output.listParties.value = group.parties.map{PartyCellViewModel(party: $0, currency: group.currency)}
                self.output.totalExpense.value = group.totalExpense()
            }
        }).disposed(by: disposeBag)
        input.partyIndexSelected.subscribe(onNext: {[unowned self] index in
            if let party = self.group?.parties[index]{
                self.router.enqueueRoute(with: GroupDetailRouter.RouteType.partyDetail(group: self.group!, party: party))
            }
        }).disposed(by: disposeBag)
        input.showDiary.subscribe(onNext: {[unowned self] value in
            if value{
                self.router.enqueueRoute(with: GroupDetailRouter.RouteType.goDiary(group: self.group))
            }
        }).disposed(by: disposeBag)
        input.deletePartyIndex.subscribe(onNext:{index in
            let partyDelete = self.group.parties[index]
            DBService().deleteParty(party: partyDelete)
            self.input.fetchData.onNext(true)
        }).disposed(by: disposeBag)
    }
    
}
