//
//  AppDelegate.swift
//  SplitwiseApp
//
//  Created by Charlie on 3/14/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//    var coordinator: Router!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initApp()
        return true
    }
}

extension AppDelegate{
    
    func initApp(){
        initApperance()
        
        let _window = UIWindow()
//        let navigationController = UINavigationController()
//        window?.rootViewController = navigationController
//        let coordinator = Router(navigationController: navigationController)
//        self.coordinator = coordinator
        
        let appCoordinator = AppCoordinator()
        appCoordinator.presentInitialScreen(on: _window)
        _window.makeKeyAndVisible()
        self.window = _window
        
    }
    func initApperance(){
        UINavigationBar.appearance().barTintColor = UIColor(red: 245/255, green: 195/255, blue: 84/255, alpha: 1.0)
    }
}
