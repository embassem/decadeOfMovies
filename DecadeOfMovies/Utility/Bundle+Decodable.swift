//
//  Bundle+Decodable.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// Decode Objects from Json file
    /// - Parameters:
    ///   - type: the Entity Type that confirm to Decodable
    ///   - file: json file name with extension
    ///   - dateDecodingStrategy: decode date prefrance
    ///   - keyDecodingStrategy: the json Key style
    /// - Returns:  the Decoded Object
    /// - Exampler: let user = Bundle.main.decode(User.self, from: "data.json")
    /// - source: https://www.hackingwithswift.com/example-code/system/how-to-decode-json-from-your-app-bundle-the-easy-way
    func decode<T: Decodable>(_ type: T.Type,
                              from file: String,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .secondsSince1970,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys)
        -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("""
                Failed to decode \(file) from bundle due to
                missing key '\(key.stringValue)' not found
                – \(context.debugDescription)
                """)
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("""
                Failed to decode \(file) from bundle due to
                missing \(type) value –
                \(context.debugDescription)
                """)
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
