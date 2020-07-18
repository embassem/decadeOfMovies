//
//  FlikerAPIResponse.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

struct FlikerAPIResponse: Codable {

    let photos: Photos?
    let stat: String?

    enum CodingKeys: String, CodingKey {
        case photos
        case stat = "stat"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        photos = try values.decodeIfPresent(Photos.self, forKey: .photos)
        stat = try values.decodeIfPresent(String.self, forKey: .stat)
    }

}

struct Photos: Codable {

    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: String?
    let photos: [FlickrPictureModel]?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case pages = "pages"
        case perpage = "perpage"
        case total = "total"
        case photos = "photo"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        pages = try values.decodeIfPresent(Int.self, forKey: .pages)
        perpage = try values.decodeIfPresent(Int.self, forKey: .perpage)
        total = try values.decodeIfPresent(String.self, forKey: .total)
        photos = try values.decodeIfPresent([FlickrPictureModel].self, forKey: .photos)
    }

}
