//
//  BasePresenter.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

class BasePresenter<View: BaseViewProtocol, Model: BaseModelProtocol>: NSObject,
BasePresenterProtocol {

    private var view: View?
    private var model: Model?

    private override init() {

    }

    init(view: View, model: Model ) {
        self.view = view
        self.model = model
    }

    func showErrorMessage(message: String) {
        view?.showError(message: message)
    }

}
