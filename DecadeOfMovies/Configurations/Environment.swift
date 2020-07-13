//
//  Environment.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

public enum Environment {

    // MARK: - Keys
    enum Keys {
        static let domain = "BASE_DOMAIN"
    }

    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    // MARK: - Plist values
    static let rootURL: String = {
        guard let rootURLstring = Environment.infoDictionary[Keys.domain] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        let baseUrl = "https://\(rootURLstring)"
        guard let url = URL(string: baseUrl ) else {
            fatalError("Root URL is invalid")
        }
        return url.absoluteString
    }()
}
