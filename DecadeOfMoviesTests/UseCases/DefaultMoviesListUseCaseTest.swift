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
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let localStorage = JSONMoviesResponseStorage()
        let repository = DefaultMoviesRepository(local: localStorage)
        sut = DefaultSearchMoviesUseCase(moviesRepository: repository)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
