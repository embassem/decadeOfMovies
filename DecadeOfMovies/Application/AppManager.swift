//
//  AppManager.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation
import UIKit

class AppManager: NSObject {

    static let shared: AppManager = AppManager()

    private(set) var window: UIWindow?

    private var appCoordinator: AppCoordinator! {
        didSet {
            appCoordinator.start()
        }
    }
    
    private override init() {
        super.init()
        configerNetworking()
    }
    static func launchApp(_ application: UIApplication) {

        if #available(iOS 13, *) {
            // use UICollectionViewCompositionalLayout
            //Scene Delegate will call  initWindow(windowScene: UIWindowScene)
        } else {
            // show sad face emoji
            initWindow()
        }

    }

    func configerNetworking() {
    }

    static func initWindow() {

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.shared.window = window
        self.shared.appCoordinator = AppCoordinator(window: window, navigationController: AppNavigationController())
    }

    @available(iOS 13.0, *)
    static func initWindow(windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        self.shared.window = window
        self.shared.appCoordinator = AppCoordinator(window: window, navigationController: AppNavigationController())
    }

    class func setWindowRoot(_ viewController: UIViewController) {
        shared.window?.rootViewController = viewController
    }

    class func setWindowTransition(_ viewController: UIViewController) {
        shared.window?.setRootViewControllerWithTransition(viewController)
    }

}
