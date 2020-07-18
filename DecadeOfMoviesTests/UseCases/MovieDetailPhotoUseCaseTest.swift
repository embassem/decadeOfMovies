//
//  MovieDetailPhotoUseCaseTest.swift
//  DecadeOfMoviesTests
//
//  Created by Bassem Abbas on 7/18/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import XCTest
@testable import DecadeOfMovies

class MovieDetailPhotoUseCaseTest: XCTestCase {

    var sut: DefaultMovieDetailPhotoUseCase!

    override func setUpWithError() throws {
        sut = DefaultMovieDetailPhotoUseCase(photosRepository: MoviePhotosRepositoryMock())
    }

    override func tearDownWithError() throws {
       sut = nil
    }

    func testExectutionUseCase() throws {

        let exp = expectation(description: "search photos should has result")
        var photos: [Photo]?
        sut.execute(name: "title1", page: 1) { (result) in
            photos = result.value
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        let moviesList = try XCTUnwrap(photos)
        XCTAssert(moviesList.isEmpty == false, "search photos should has result")
    }
}
