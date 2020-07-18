//
//  PhotosRemote.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

struct FlickrPictureModel: Codable {
    let farm: Int?
    let id: String?
    let isfamily: Int?
    let isfriend: Int?
    let ispublic: Int?
    let owner: String?
    let secret: String?
    let server: String?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case farm = "farm"
        case id = "id"
        case isfamily = "isfamily"
        case isfriend = "isfriend"
        case ispublic = "ispublic"
        case owner = "owner"
        case secret = "secret"
        case server = "server"
        case title = "title"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        farm = try values.decodeIfPresent(Int.self, forKey: .farm)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        isfamily = try values.decodeIfPresent(Int.self, forKey: .isfamily)
        isfriend = try values.decodeIfPresent(Int.self, forKey: .isfriend)
        ispublic = try values.decodeIfPresent(Int.self, forKey: .ispublic)
        owner = try values.decodeIfPresent(String.self, forKey: .owner)
        secret = try values.decodeIfPresent(String.self, forKey: .secret)
        server = try values.decodeIfPresent(String.self, forKey: .server)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

    var absoluteURL: String {
        guard let id = self.id,
            let farm = self.farm,
            let server = self.server,
            let secret = self.secret else { return "" }
        return "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
    }

}

extension Photo {

    init?(fliker: FlickrPictureModel) {
        guard let id = fliker.id,
            fliker.farm != nil,
            fliker.server != nil,
            fliker.secret != nil
            else { return nil }
        self.id = id
        self.absoluteURL = fliker.absoluteURL
    }
}
