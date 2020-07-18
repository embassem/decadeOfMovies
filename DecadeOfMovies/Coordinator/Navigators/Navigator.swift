//
//  Navigator.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/13/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation
import UIKit

enum NavigatorType {
    case push
    case present
    case root
    case pop
}

protocol Navigator {
    
    associatedtype Destination
    var coordinator: AppCoordinatorProtocol { get set }
    init(coordinator: AppCoordinatorProtocol)

    func navigate(to destination: UIViewController, with type: NavigatorType)
}

extension Navigator {
    
    public func navigate(to destination: UIViewController,
                         with type: NavigatorType = .push) {
        let viewController = destination

        switch type {
        case .push:
            coordinator.navigationController?.pushViewController(viewController, animated: true)
        case .present:
            coordinator.navigationController?.present(viewController, animated: true)
        case .root:
            coordinator.navigationController?.setViewControllers([viewController], animated: true)
        case .pop:
            coordinator.navigationController?.popViewController(animated: true)
        }
    }

}
