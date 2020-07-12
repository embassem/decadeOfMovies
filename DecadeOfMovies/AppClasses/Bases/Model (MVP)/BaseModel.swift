//
//  BaseModel.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

class BaseModel: NSObject,
BaseModelProtocol {

}

enum ModelsError: String, Error, LocalizedError {
    case customError = "Something went wrong."
}
