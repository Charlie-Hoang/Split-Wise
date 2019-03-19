//
//  HomeRouter.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/18/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit

class HomeRouter: SWRouter {
    
    enum RouteType {
        case groupDetail(groupId: String)
        case newGroup
    }
    
    weak var baseViewController: UIViewController?
    
    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
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
        case .groupDetail(let groupId):
            let detailRouter = GroupDetailRouter()
            let presentationContext = GroupDetailRouter.PresentationContext.groupId(groupId: groupId)
            detailRouter.present(on: baseViewController, animated: true, context: presentationContext, completion: nil)
        case .newGroup:
            let newGroupRouter = NewGroupRouter()
            newGroupRouter.present(on: baseViewController, animated: true, context: nil, completion: nil)
        }
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
}
