//
//  AppNavigationController.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit

class AppNavigationController: UINavigationController {

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = true
        }
        self.navigationBar.isTranslucent = false
        self.navigationBar.backgroundColor = UIColor.grayscale800
        self.navigationBar.barTintColor = UIColor.grayscale800
        self.navigationBar.tintColor = UIColor.grayscale200
        self.navigationBar.titleTextAttributes =
            [.foregroundColor: UIColor.grayscale200,
             .font: AppFonts.font(forTextStyle: .title1Bold)]
        if #available(iOS 13.0, *) {
            styleiOS13()
        }

        changeBackBarButtonImage()
    }

    @available(iOS 13.0, *)
    func styleiOS13() {
        let navBarAppearance = UINavigationBarAppearance()

        // Call this first otherwise it will override your customizations
        navBarAppearance.configureWithOpaqueBackground()

        navBarAppearance.titleTextAttributes = [
            .foregroundColor: Asset.Colors.grayscale200.color, // Navigation bar title color
            .font: AppFonts.font(forTextStyle: .title1Bold) // Navigation bar title font
        ]

        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: Asset.Colors.grayscale200.color, // Navigation bar title color
            .font: AppFonts.font(forTextStyle: .title2Bold) // Navigation bar title font
        ]

        navBarAppearance.backgroundColor = Asset.Colors.grayscale800.color // Navigation bar bg color
        navBarAppearance.titlePositionAdjustment =
            UIOffset(horizontal: -100, vertical: 0) // Only works on non large title

        navigationBar.standardAppearance = navBarAppearance
        navigationBar.compactAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.prefersLargeTitles = true // Activate large title
    }
}
