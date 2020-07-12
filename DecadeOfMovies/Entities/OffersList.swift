//
//	OffersList.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct OffersList: Codable {

    let sections: [Section]?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case sections = "sections"
        case title = "title"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sections = try values.decodeIfPresent([Section].self, forKey: .sections)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

}
