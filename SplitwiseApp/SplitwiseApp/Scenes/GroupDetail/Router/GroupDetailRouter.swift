//
//  GroupDetailRouter.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/18/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit

class GroupDetailRouter: SWRouter {
    
    enum PresentationContext {
//        case group(Group)
        case groupId(groupId: String)
        
    }
    
    enum RouteType {
        case partyDetail(group: Group, party: Party)
        case newParty(Group)
        case goDiary(group: Group)
    }
    
    weak var baseViewController: UIViewController?
    
    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        guard let presentationContext = context as? PresentationContext else {
            assertionFailure("The context type missmatch")
            return
        }
        
        switch presentationContext {
        case .groupId(let groupId):
            let viewController = GroupDetailVC()
            
            let viewModel = GroupDetailViewModel.init(with: self, groupId: groupId)
            viewController.viewModel = viewModel
            
            baseVC.navigationController?.pushViewController(viewController, animated: true)
            baseViewController = baseVC
        }
    }
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
        guard let routeType = context as? RouteType else {
            assertionFailure("The route type missmatches")
            return
        }
        
        guard let baseViewController = baseViewController else {
            assertionFailure("baseViewController is not set")
            return
        }
        
        switch routeType {
        case .partyDetail(let group, let party):
            let newPartyRouter = NewPartyRouter()
            let presentationContext = NewPartyRouter.PresentationContext.model(group: group, party: party)
            newPartyRouter.present(on: baseViewController, animated: true, context: presentationContext, completion: nil)
        case .newParty(let group):
            let newPartyRouter = NewPartyRouter()
            let presentationContext = NewPartyRouter.PresentationContext.group(group)
            newPartyRouter.present(on: baseViewController, animated: true, context: presentationContext, completion: nil)
        case .goDiary(let group):
            let diaryRouter = DiaryRouter()
            let presentationContext = DiaryRouter.PresentationContext.group(group)
            diaryRouter.present(on: baseViewController, animated: true, context: presentationContext, completion: nil)
        }
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
}
