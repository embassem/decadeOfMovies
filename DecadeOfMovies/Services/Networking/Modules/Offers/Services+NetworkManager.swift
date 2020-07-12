//
//  Services+NetworkManager.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation
import Moya

protocol OffersService {
    func getOffers( completion: @escaping (
        _ result: Swift.Result<OffersList, APIError>,
        _ statusCode: StatusCode?
        ) -> Void)

    func getOfferDetails( id: Int, completion: @escaping (
        _ result: Swift.Result<OfferDetails, APIError>,
        _ statusCode: StatusCode?
        ) -> Void)
}
extension NetworkManager: OffersService {

    func getOffers( completion: @escaping (
        _ result: Swift.Result<OffersList, APIError>,
        _ statusCode: StatusCode?
        ) -> Void) {
        provider.request(MultiTarget(Services.getOffers)) { (result) in
            self.parseResponse(moyaResult: result, completion: completion)
        }
    }

    func getOfferDetails( id: Int, completion: @escaping (
        _ result: Swift.Result<OfferDetails, APIError>,
        _ statusCode: StatusCode?
        ) -> Void) {
        provider.request(MultiTarget(Services.getOfferDetails(id: id))) { (result) in
            self.parseResponse(moyaResult: result, completion: completion)
        }
    }
}
