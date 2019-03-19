//
//  DiaryRouter.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit

class DiaryRouter: SWRouter {
    
    enum PresentationContext {
        case group(Group)
    }
    
    enum RouteType {
        case goBalance(Group)
    }
    
    weak var baseViewController: UIViewController?
    
    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        guard let presentationContext = context as? PresentationContext else {
            assertionFailure("The context type missmatch")
            return
        }
        
        switch presentationContext {
        case .group(let group):
            
            let viewModel = DiaryViewModel.init(with: self, group: group)
            let viewController = DiaryVC()
            
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
        case .goBalance(let group):
            let balanceRouter = BalanceRouter()
            let presentationContext = BalanceRouter.PresentationContext.group(group)
            balanceRouter.present(on: baseViewController, animated: true, context: presentationContext, completion: nil)
        }
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
}
