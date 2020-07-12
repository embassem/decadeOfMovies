//
//	OfferDetails.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct OfferDetails: Codable {

    let brand: String?
    let descriptionField: String?
    let expiration: String?
    let favoriteCount: Int?
    var id: Int?
    let imageUrl: String?
    let price: Price?
    let redemptionsCap: String?
    let tags: String?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case brand = "brand"
        case descriptionField = "description"
        case expiration = "expiration"
        case favoriteCount = "favoriteCount"
        case id = "id"
        case imageUrl = "imageUrl"
        case price
        case redemptionsCap = "redemptionsCap"
        case tags = "tags"
        case title = "title"
    }

    init(item: Item) {
        self.brand = item.brand
        self.favoriteCount = item.favoriteCount
        self.imageUrl = item.imageUrl
        self.tags = item.tags
        self.title = item.title

        descriptionField = nil
        expiration = nil
        id = nil
        price = nil
        redemptionsCap = nil

        if let idFromPath = item.detailUrl?.split(separator: "/").last {
            let idString = String(idFromPath)
            if let intId = Int(idString) {
                self.id = intId
            }
        }
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        expiration = try values.decodeIfPresent(String.self, forKey: .expiration)
        favoriteCount = try values.decodeIfPresent(Int.self, forKey: .favoriteCount)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        redemptionsCap = try values.decodeIfPresent(String.self, forKey: .redemptionsCap)
        tags = try values.decodeIfPresent(String.self, forKey: .tags)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

}
