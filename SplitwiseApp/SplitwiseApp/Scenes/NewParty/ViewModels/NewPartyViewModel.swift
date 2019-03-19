//
//  NewPartyViewModel.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/18/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

protocol NewPartyViewModelInputProtocol {
    func save()
    var paidBySelected: Variable<Int>{get}
    var memberSlected: PublishSubject<Int>{get}

}
protocol NewPartyViewModelOutputProtocol {
    var title: Variable<String>{get}
    var amount: Variable<String>{get}
    var listMembers: Variable<[MemberInPartyViewModel]>{get}
    var paidBy: Variable<String>{get}
    var dateString: Variable<String>{get}
    var currencySymbol: Variable<String>{get}
}
protocol NewPartyViewModelProtocol: SWViewModel {
    var input: NewPartyViewModelInputProtocol{get}
    var output: NewPartyViewModelOutputProtocol{get}
}
class NewPartyViewModel: NewPartyViewModelProtocol, NewPartyViewModelInputProtocol, NewPartyViewModelOutputProtocol{
    
    var input: NewPartyViewModelInputProtocol{return self}
    var output: NewPartyViewModelOutputProtocol{return self}
    
    var title = Variable<String>("")
    var amount = Variable<String>("")
    var listMembers = Variable<[MemberInPartyViewModel]>([])
    var dateString = Variable<String>("")
    var paidBy = Variable<String>("")
    var paidBySelected = Variable<Int>(0)
    var memberSlected = PublishSubject<Int>()
    var currencySymbol = Variable<String>("")
    
    var group = Group()
    var router: SWRouter
    var party: Party!
    
    private let disposeBag = DisposeBag()
    
    init(with router: SWRouter, group: Group) {
        self.router = router
        self.group = group
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.initFromGroup()
        }
        binding()
    }
    init(with router: SWRouter, group: Group, party: Party){
        self.router = router
        self.group = group
        self.party = party
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.initFromParty()
        }
        binding()
    }
    func initFromParty(){
        output.title.value = party.title ?? ""
        output.amount.value = String(format: "%.2f", party.amount.value ?? "")
        output.dateString.value = (party.date ?? Date()).swString()!
        output.paidBy.value = party.paidBy?.name ?? group.membersName()[0]
        output.listMembers.value = group.members.map{member in
            
            var memberViewModel = MemberInPartyViewModel(member: member)
            let found = self.party.members.filter{$0.id == member.id}
            if found.isEmpty{
                memberViewModel.checked = false
            }
            return memberViewModel
        }
        input.paidBySelected.value = group.membersName().firstIndex(of: output.paidBy.value) ?? 0
//        input.paidBySelected.onNext(group.membersName().firstIndex(of: output.paidBy.value) ?? 0)
    }
    func initFromGroup(){
        output.listMembers.value = group.members.map{ return MemberInPartyViewModel(member: $0) }
        output.paidBy.value = group.membersName()[0]
        output.dateString.value = Date().swString()!
    }
    func binding(){
        output.currencySymbol.value = group.currency ?? ""
        input.paidBySelected.asObservable().subscribe(onNext: {[unowned self] index in
            self.paidBy.value = self.group.membersName()[index]
        }).disposed(by: disposeBag)
//        self.paidBy.value = self.group.membersName()[input.paidBySelected.value]
        input.memberSlected.subscribe(onNext: {[unowned self] index in
            var member = self.listMembers.value[index]
            member.checked = !member.checked!
            self.listMembers.value = self.listMembers.value.enumerated().map{(idx, value) in
                if idx == index{
                    return member
                }
                return value
            }
        }).disposed(by: disposeBag)
    }
    func save() {
        if let _ = self.party{
            saveEdit()
        }else{
            saveNew()
        }
        self.router.enqueueRoute(with: NewPartyRouter.RouteType.save)
    }
    func saveNew() {
        
        guard !title.value.isEmpty else {return}
        guard Double(amount.value) != 0 else {return}
        DBService().update(group: group) {
            let newParty = Party()
            newParty.title = title.value
            newParty.amount.value = Double(amount.value)
            newParty.members.append(objectsIn: self.listMembers.value.filter({$0.checked!}).map{$0.model})
            newParty.paidBy = self.group.members[input.paidBySelected.value]
            newParty.date = output.dateString.value.swDate()
            group.parties.append(newParty)
        }
    }
    func saveEdit(){
        guard !title.value.isEmpty else {return}
        guard Double(amount.value) != 0 else {return}
        DBService().update(group: group) {
            party.title = title.value
            party.amount.value = Double(amount.value)
            party.members.removeAll()
            party.members.append(objectsIn: self.listMembers.value.filter({$0.checked!}).map{$0.model})
            self.party.paidBy = self.group.members[input.paidBySelected.value]
            party.date = output.dateString.value.swDate()
        }
        
    }
}
