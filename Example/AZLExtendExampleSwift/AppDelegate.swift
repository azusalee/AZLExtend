//
//  AppDelegate.swift
//  AZLExtendExampleSwift
//
//  Created by lizihong on 2021/7/19.
//  Copyright © 2021 azusalee. All rights reserved.
//

import UIKit

extension ViewController {
    class func swizzleFunc() {
        self.azl_swizzleInstanceFunc(oriSel: #selector(viewDidLoad), swizzleSel: #selector(swz_viewDidLoad))
    }

    @objc func swz_viewDidLoad() {
        self.swz_viewDidLoad()
        print("交换方法成功")
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ViewController.swizzleFunc()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

