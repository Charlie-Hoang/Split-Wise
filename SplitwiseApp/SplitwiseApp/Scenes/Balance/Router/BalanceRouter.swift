//
//  BalanceRouter.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/19/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit

class BalanceRouter: SWRouter {
    
    enum PresentationContext {
        case group(Group)
    }
    
    enum RouteType {
    }
    
    weak var baseViewController: UIViewController?
    
    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        guard let presentationContext = context as? PresentationContext else {
            assertionFailure("The context type missmatch")
            return
        }
        
        switch presentationContext {
        case .group(let group):
            
            let viewModel = BalanceViewModel.init(with: self, group: group)
            let viewController = BalaceVC()
            
            viewController.viewModel = viewModel
            
            baseVC.navigationController?.pushViewController(viewController, animated: true)
            baseViewController = baseVC
        }
    }
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
}
