//
//  AppCoordinator.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/18/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator {
    
    func presentInitialScreen(on window: UIWindow) {
        let router = HomeRouter()
        
        let viewModel = HomeViewModel.init(with: router)
        let viewController = HomeVC()
        let navigationVC = UINavigationController(rootViewController: viewController)
        
        viewController.viewModel = viewModel
        router.baseViewController = viewController
        
        window.rootViewController = navigationVC
    }
    
}
