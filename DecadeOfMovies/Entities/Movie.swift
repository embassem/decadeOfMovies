//
//	Movy.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Movie: Codable {

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
