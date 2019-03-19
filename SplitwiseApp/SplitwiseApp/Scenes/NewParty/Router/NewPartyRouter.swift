//
//  NewPartyRouter.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/18/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit

class NewPartyRouter: SWRouter {
    
    enum PresentationContext {
        case group(Group)
        case model(group: Group, party: Party)
    }
    
    enum RouteType {
        case save
    }
    
    weak var baseViewController: UIViewController?
    
    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        guard let presentationContext = context as? PresentationContext else {
            assertionFailure("The context type missmatch")
            return
        }
        
        switch presentationContext {
        case .model(let group, let party):
            let viewController = NewPartyVC()
            
            let viewModel = NewPartyViewModel.init(with: self, group: group, party: party)
            viewController.viewModel = viewModel
            
            baseVC.navigationController?.pushViewController(viewController, animated: true)
            baseViewController = baseVC
        case .group(let group):
            let viewController = NewPartyVC()
            
            let viewModel = NewPartyViewModel.init(with: self, group: group)
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
        
        guard let _ = baseViewController else {
            assertionFailure("baseViewController is not set")
            return
        }
        
        switch routeType {
        case .save:
            baseViewController?.navigationController?.popViewController(animated: true)
        }
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
}
