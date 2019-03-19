//
//  NewGroupRouter.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/18/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit

class NewGroupRouter: SWRouter {
    
    enum RouteType {
//        case groupDetail(Group)
        case save
    }
    
    weak var baseViewController: UIViewController?
    
    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        let viewController = NewGroupVC()
        
        let viewModel = NewGroupViewModel.init(with: self)
        viewController.viewModel = viewModel
        
        baseVC.navigationController?.pushViewController(viewController, animated: true)
        baseViewController = baseVC
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
//        case .groupDetail(let group): print("a")
            //            let detailsRouter = RepoDetailsRouter()
            //            let presentationContext = RepoDetailsRouter.PresentationContext.view(repo)
        //            detailsRouter.present(on: baseViewController, animated: true, context: presentationContext, completion: nil)
        case .save:
            baseViewController?.navigationController?.popViewController(animated: true)
            print("sd")
        }
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
}
