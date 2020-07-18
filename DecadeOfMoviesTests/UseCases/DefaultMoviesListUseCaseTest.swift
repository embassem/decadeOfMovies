//
//  DefaultMoviesListUseCaseTest.swift
//  DecadeOfMoviesTests
//
//  Created by Bassem Abbas on 7/18/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import XCTest
@testable import DecadeOfMovies

class DefaultMoviesListUseCaseTest: XCTestCase {

    var sut: DefaultSearchMoviesUseCase!

    override func setUpWithError() throws {
        let localStorage = JSONMoviesResponseStorage()
        let repository = DefaultMoviesRepository(local: localStorage)
        sut = DefaultSearchMoviesUseCase(moviesRepository: repository)
    }

    override func tearDownWithError() throws {
      sut = nil
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            let exp = expectation(description: "search found all result ")
            var movies: [Movie]?
            sut.execute(query: "a") { (result) in
                movies = result.value
                exp.fulfill()
            }
            waitForExpectations(timeout: 3)
            print("measure performance for query with 'a' that list : \(movies?.count ?? 0) item")
            XCTAssertNotNil(movies, "movies should not be nil")
        }
    }
}
