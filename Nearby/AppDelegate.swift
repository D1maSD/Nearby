//
//  AppDelegate.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 09.01.2024.
//

import UIKit
import YandexMapsMobile

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var enviroment = Enviorment()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = RegisterModuleRouter.createModule()
        YMKMapKit.setApiKey(enviroment.yandexMapApiKey)
        YMKMapKit.sharedInstance()
        let navigationVC = CustomNavigationController(vc)
        self.window = UIWindow(frame:UIScreen.main.bounds)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

}

