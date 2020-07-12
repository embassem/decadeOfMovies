//
//  Container.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit

class Container {

    class func getSplashScene() -> UIViewController {
        return SplashViewController()
    }

    class Root {
        class func getRootScene() -> UIViewController {
            return getMoviewsListScene()
        }

        class func getMoviewsListScene() -> UIViewController {
            let movies = MoviesListViewController()
            movies.edgesForExtendedLayout = .all
            movies.extendedLayoutIncludesOpaqueBars = true
            return movies.embadInNav()
        }
    }
}

fileprivate extension UIViewController {

    func embadInNav(hideBar: Bool = false) -> UINavigationController {
        let nav = AppNavigationController(rootViewController: self)
        nav.view.backgroundColor = UIColor.white
        nav.isNavigationBarHidden = hideBar
        return nav
    }

}
