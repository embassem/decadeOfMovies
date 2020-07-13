//
//  MoviesJSON.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

struct MoviesJSON: Codable {

    let movies: [MovieJSON]?

    enum CodingKeys: String, CodingKey {
        case movies = "movies"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movies = try values.decodeIfPresent([MovieJSON].self, forKey: .movies)
    }

}

struct MovieJSON: Codable {

    let cast: [String]?
    let genres: [String]?
    let rating: Int?
    let title: String?
    let year: Int?

    enum CodingKeys: String, CodingKey {
        case cast = "cast"
        case genres = "genres"
        case rating = "rating"
        case title = "title"
        case year = "year"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cast = try values.decodeIfPresent([String].self, forKey: .cast)
        genres = try values.decodeIfPresent([String].self, forKey: .genres)
        rating = try values.decodeIfPresent(Int.self, forKey: .rating)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        year = try values.decodeIfPresent(Int.self, forKey: .year)
    }

}

extension MovieJSON {
    func toMovie() -> Movie {
        return Movie(
            title: self.title,
            year: self.year,
            rating: self.rating,
            genres: self.genres,
            cast: self.cast)
    }
}
