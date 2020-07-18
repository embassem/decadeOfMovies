//
//  Photos+Stubs.swift
//  DecadeOfMoviesTests
//
//  Created by Bassem Abbas on 7/18/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

@testable import DecadeOfMovies

extension Photo {

    static func stubs() -> [Photo] {

        let photo1 = Photo(id: "1", absoluteURL: "https://picsum.photos/200/300")
        let photo2 = Photo(id: "2", absoluteURL: "https://picsum.photos/200/300")
        let photo3 = Photo(id: "3", absoluteURL: "https://picsum.photos/200/300")
        let photo4 = Photo(id: "4", absoluteURL: "https://picsum.photos/200/300")
        let photo5 = Photo(id: "5", absoluteURL: "https://picsum.photos/200/300")

        return [photo1, photo2, photo3, photo4, photo5]
    }
}
