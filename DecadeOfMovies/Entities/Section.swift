//
//	Section.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Section: Codable {

    let items: [Item]?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case title = "title"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decodeIfPresent([Item].self, forKey: .items)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

}
