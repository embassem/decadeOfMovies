//
//	Item.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Item: Codable {

    let brand: String?
    let detailUrl: String?
    let favoriteCount: Int?
    let imageUrl: String?
    let tags: String?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case brand = "brand"
        case detailUrl = "detailUrl"
        case favoriteCount = "favoriteCount"
        case imageUrl = "imageUrl"
        case tags = "tags"
        case title = "title"
    }
    init() {
        brand = nil
        detailUrl = nil
        favoriteCount = nil
        imageUrl = nil
        tags = nil
        title = nil
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        detailUrl = try values.decodeIfPresent(String.self, forKey: .detailUrl)
        favoriteCount = try values.decodeIfPresent(Int.self, forKey: .favoriteCount)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        tags = try values.decodeIfPresent(String.self, forKey: .tags)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

}

extension Item {
    static func sampleItem() -> Item? {
        if let path = Bundle.main.path(forResource: "offerList", ofType: "json" ) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let offers = try JSONDecoder().decode(OffersList.self, from: data)
                return offers.sections?.first?.items?.first
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}
