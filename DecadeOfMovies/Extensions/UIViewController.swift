//
//  UIViewController.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit

extension UIViewController {

    public func isViewLoadedAndShowing() -> Bool { return isViewLoaded && view.window != nil }

    func push( viewController: UIViewController, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        navigationController?.pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
}
