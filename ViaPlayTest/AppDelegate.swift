//
//  AppDelegate.swift
//  ViaPlayTest
//
//  Created by Ivan Makarov on 29.06.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        
        let mainAssembly = MainAssembly()
        let sectionDetailsAssembly = SectionDetailsAssembly()
        
        let mainCoordinator = MainFlowCoordinator(
            navigationController: navigationController,
            mainScreenAssembly: mainAssembly,
            sectionDetailsAssembly: sectionDetailsAssembly
        )
        
        mainCoordinator.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}

