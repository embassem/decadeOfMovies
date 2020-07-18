//
//  MoviesListUseCaseTest.swift
//  DecadeOfMoviesTests
//
//  Created by Bassem Abbas on 7/18/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import XCTest
@testable import DecadeOfMovies

class MoviesListUseCaseTest: XCTestCase {

    var sut: DefaultMoviesListUseCase!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = DefaultMoviesListUseCase(moviesRepository: MoviesRepositoryMock())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testExecuteUseCase() throws {
        let exp = expectation(description: "movies load")
        var movies: [Movie]?
        sut.execute { (result) in
            movies = result.value
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(movies, "Movies should be loaded")
        let moviesList = try XCTUnwrap(movies)
        XCTAssert(moviesList.isEmpty == false, "Movies list should exist")
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
