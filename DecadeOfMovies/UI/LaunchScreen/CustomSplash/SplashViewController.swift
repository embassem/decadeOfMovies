//
//  SplashViewController.swift
//  The Valley
//
//  Created by Bassem Abbas on 3/3/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet private weak var logoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        startAnimation()
    }

    fileprivate func startAnimation() {
        //logoImageView.transform = .init(scaleX: 0, y: 0)

        UIView.animate(
            withDuration: 15,
            delay: 0.3,
            usingSpringWithDamping: 4,
            initialSpringVelocity: 5,
            options: .curveEaseInOut,
            animations: {
                self.logoImageView.transform = .identity
        }, completion: { _ in
            self.animationCompleted()
        })
    }
    fileprivate func animationCompleted() {
        //TODO: Navigate to root View

    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
