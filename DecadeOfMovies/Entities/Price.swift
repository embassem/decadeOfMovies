//
//	Price.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Price: Codable {

    let newField: String?
    let old: String?

    enum CodingKeys: String, CodingKey {
        case newField = "new"
        case old = "old"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        newField = try values.decodeIfPresent(String.self, forKey: .newField)
        old = try values.decodeIfPresent(String.self, forKey: .old)
    }

}
