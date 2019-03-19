//
//  HomeViewModel.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/14/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

protocol HomeViewModelInputProtocol {
    var fetchGroups: PublishSubject<Bool>{get}
    var newGroupButtonSelected: PublishSubject<Bool>{get}
    var groupIndexSelected: PublishSubject<Int>{get}
    var deleteGroupIndex: PublishSubject<Int>{get}
}
protocol HomeViewModelOutputProtocol {
    var listGroups: Variable<[GroupCellViewModel]>{get}
}
protocol HomeViewModelProtocol: SWViewModel {
    var input: HomeViewModelInputProtocol{get}
    var output: HomeViewModelOutputProtocol{get}
}
class HomeViewModel: HomeViewModelProtocol, HomeViewModelInputProtocol, HomeViewModelOutputProtocol{
    
    var input: HomeViewModelInputProtocol{return self}
    var output: HomeViewModelOutputProtocol{return self}
    
    var listGroups = Variable<[GroupCellViewModel]>([])
    var newGroupButtonSelected = PublishSubject<Bool>()
    let groupIndexSelected = PublishSubject<Int>()
    var fetchGroups = PublishSubject<Bool>()
    var deleteGroupIndex = PublishSubject<Int>()
    
    var groups = [Group]()
    var router: SWRouter
    
    private let disposeBag = DisposeBag()
    
    init(with router: SWRouter) {
        self.router = router
        binding()
    }
    func binding(){
        input.newGroupButtonSelected.subscribe(onNext: {[unowned self] value in
            if value{
                self.router.enqueueRoute(with: HomeRouter.RouteType.newGroup)
            }
        }).disposed(by: disposeBag)
        input.groupIndexSelected.subscribe(onNext: {[unowned self] index in
            let group = self.groups[index]
            self.router.enqueueRoute(with: HomeRouter.RouteType.groupDetail(groupId: group.id))
        }).disposed(by: disposeBag)
        
        input.fetchGroups.subscribe(onNext:{[unowned self] value in
            if value{
                let res: Results<Group> = DBService().fetchGroups()
                self.groups = Array(res)
                self.output.listGroups.value = res.map{GroupCellViewModel(group: $0)}
            }
        }).disposed(by: disposeBag)
        input.deleteGroupIndex.subscribe(onNext:{index in
            let groupDelete = self.groups[index]
            DBService().deleteGroup(group: groupDelete)
            self.input.fetchGroups.onNext(true)
        }).disposed(by: disposeBag)
    }
}
