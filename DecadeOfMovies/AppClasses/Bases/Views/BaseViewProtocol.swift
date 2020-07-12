//
//  BaseView.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation
import Toast

protocol BaseViewProtocol: class {

    func showLoading(allowNavigation: Bool)

    func hideLoading()

    func showError(message: String)

    func showToast(message: String)
}

extension BaseViewProtocol where Self: BaseViewController {

    func showLoading(allowNavigation: Bool) {

    }

    func hideLoading() {

    }

    func showError(message: String) {
        self.view.makeToast(message, duration: 3.0, position: .top)
        //TODO: add SwiftMessages and replace with toast
        //        let view = MessageView.viewFromNib(layout: .cardView)
        //        view.button?.isHidden = true
        //        view.configureTheme(.error)
        //        view.configureDropShadow()
        //        var config = SwiftMessages.Config()
        //        config.duration = .seconds(seconds: 2.0)
        //        config.presentationContext = .window(windowLevel: .statusBar)
        //        view.configureContent(title: L10n.General.Error.title, body: message)
        //        view.layoutMarginAdditions = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //        view.backgroundView.layer.cornerRadius = 8
        //        SwiftMessages.show(config: config, view: view)

    }

    func showToast(message: String) {
        self.view.makeToast(message, duration: 3.0, position: .bottom)

    }
}
