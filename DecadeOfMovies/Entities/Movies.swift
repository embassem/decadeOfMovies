//
//	Movies.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Movies: Codable {

    let movies: [Movie]?

    enum CodingKeys: String, CodingKey {
        case movies = "movies"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movies = try values.decodeIfPresent([Movie].self, forKey: .movies)
    }

}
