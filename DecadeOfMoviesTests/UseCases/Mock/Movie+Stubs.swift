//
//  Movie+Stubs.swift
//  DecadeOfMoviesTests
//
//  Created by Bassem Abbas on 7/18/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation
@testable import DecadeOfMovies

extension Movie {

    static func stubs() -> [Movie] {

        let mov1 = Movie(title: "title1", year: 2020, rating: 1, genres: nil, cast: nil)
        let mov2 = Movie(title: "title2 top", year: 2019, rating: 2, genres: nil, cast: nil)
        let mov3 = Movie(title: "title3 top", year: 2019, rating: 3, genres: nil, cast: nil)
        let mov4 = Movie(title: "title4", year: 2017, rating: 4, genres: nil, cast: nil)
        let mov5 = Movie(title: "title5", year: 2016, rating: 5, genres: nil, cast: nil)

        return [mov1, mov2, mov3, mov4, mov5]
    }
}
