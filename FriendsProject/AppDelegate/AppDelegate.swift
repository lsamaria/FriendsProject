//
//  AppDelegate.swift
//  FriendsProject
//
//  Created by LanceMacBookPro on 12/1/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let loginViewModel = LoginViewModel()
        let loginVC = LoginController(loginViewModel: loginViewModel)
        
        window?.rootViewController = loginVC
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

