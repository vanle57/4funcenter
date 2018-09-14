//
//  AppDelegate.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityIndicator
import IQKeyboardManagerSwift
import FacebookCore
import LGSideMenuController

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    enum RootViewController {
        case logined
        case notLogin
    }

    static let shared: AppDelegate = {
        guard let shared = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cannot cast `UIApplication.shared.delegate` to `AppDelegate`.")
        }
        return shared
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        configIQKeyBoardManager()
        configNetwork()
        if App.userDefault.string(forKey: App.KeyUserDefault.accessToken) != nil {
            switchRoot(rootType: .logined)
        } else {
            switchRoot(rootType: .notLogin)
        }
        window?.makeKeyAndVisible()
        return true
    }

    func configIQKeyBoardManager() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().canAdjustAdditionalSafeAreaInsets = true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        return SDKApplicationDelegate.shared.application(app, open: url, options: options)
    }

    func switchRoot(rootType: RootViewController) {
        switch rootType {
        case .logined:
            let homeNC = BaseNavigationController(rootViewController: HomeViewController())
            let mainViewController = MainViewController()
            mainViewController.rootViewController = homeNC
            mainViewController.setup()
            window?.rootViewController = mainViewController
        case .notLogin:
            let loginVC = LoginViewController()
            let navi = BaseNavigationController(rootViewController: loginVC)
            window?.rootViewController = navi
        }
    }
}

extension AppDelegate {

    private func configNetwork() {
        NetworkActivityIndicatorManager.shared.isEnabled = true
        NetworkActivityIndicatorManager.shared.startDelay = 0
    }
}
