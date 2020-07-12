//
//  NavigationBar+Appearance.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit

extension UINavigationController {

    func changeBackBarButtonImage() {

        //swiftlint:disable:next object_literal
        guard var backButtonBackgroundImage: UIImage = UIImage(named: "ic_back_arrow") else { return }

        // The background should be pinned to the left and not stretch.
        backButtonBackgroundImage = backButtonBackgroundImage
            .resizableImage(withCapInsets: UIEdgeInsets(top: 0,
                                                        left: -1,
                                                        bottom: 0,
                                                        right: 0))
        self.navigationBar.backIndicatorImage = backButtonBackgroundImage
        self.navigationBar.backIndicatorTransitionMaskImage = backButtonBackgroundImage

        // Provide an empty backBarButton to hide the 'Back' text present by default in the back button.
        let backBarButtton = UIBarButtonItem(title: "  ", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton

    }

}

extension UIApplicationDelegate {

    func changeBackBarButtonImage() {

        //swiftlint:disable:next object_literal
        guard var backButtonBackgroundImage: UIImage = UIImage(named: "ic_back_arrow") else { return }

        // The background should be pinned to the left and not stretch.
        backButtonBackgroundImage = backButtonBackgroundImage
            .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0))
        let barAppearance = UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self])
        //        var barAppearance = UINavigationBar.appearance(whenContainedInInstancesOf:[AppNavigationController.self])

        barAppearance.backIndicatorImage = backButtonBackgroundImage
        barAppearance.backIndicatorTransitionMaskImage = backButtonBackgroundImage
    }
}
extension UINavigationItem {
    func removeBackBarButtonTitle() {
        // Provide an empty backBarButton to hide the 'Back' text present by
        // default in the back button.
        //
        // NOTE: You do not need to provide a target or action.  These are set
        //       by the navigation bar.
        // NOTE: Setting the title of this bar button item to ' ' (space) works
        //       around a bug in iOS 7.0.x where the background image would be
        //       horizontally compressed if the back button title is empty.

        let backBarButton: UIBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.backBarButtonItem = backBarButton

    }

}
