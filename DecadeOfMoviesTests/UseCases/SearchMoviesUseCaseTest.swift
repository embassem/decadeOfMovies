//
//  SearchMoviesUseCaseTest.swift
//  DecadeOfMoviesTests
//
//  Created by Bassem Abbas on 7/18/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import XCTest
@testable import DecadeOfMovies

class SearchMoviesUseCaseTest: XCTestCase {

    var sut: DefaultSearchMoviesUseCase!

    override func setUpWithError() throws {

        sut = DefaultSearchMoviesUseCase(moviesRepository: MoviesRepositoryMock())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExecuteFoundAllResult() throws {

        let exp = expectation(description: "search found all result ")
        var movies: [Movie]?
        sut.execute(query: "tit") { (result) in
            movies = result.value
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        let moviesList = try XCTUnwrap(movies)
        XCTAssert(moviesList.count == 5, "search resturn all results")
    }

    func testExecuteFoundExactResult() throws {

        let exp = expectation(description: "search found one result")
        var movies: [Movie]?
        sut.execute(query: "1") { (result) in
            movies = result.value
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        let moviesList = try XCTUnwrap(movies)
        XCTAssert(moviesList.count == 1, "search should resturn one result")
    }

    func testExecuteFoundNoResult() throws {

        let exp = expectation(description: "search found non exist movie")
        var movies: [Movie]?
        sut.execute(query: "2012") { (result) in
            movies = result.value
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        let moviesList = try XCTUnwrap(movies)
        XCTAssert(moviesList.isEmpty == true, "search should not get any result")
    }

    func testResultOrderdByRatingResult() throws {
        //TODO:
        let exp = expectation(description: "search result should be ordered by rating")
        var movies: [Movie]?
        sut.execute(query: "top") { (result) in
            movies = result.value
            exp.fulfill()
        }
        waitForExpectations(timeout: 2)
        let moviesList = try XCTUnwrap(movies)

        let title3index = moviesList.firstIndex(where: { $0.title == "title3 top" }) ?? 0
        let title2index = moviesList.firstIndex(where: { $0.title == "title2 top" }) ?? 0

        XCTAssert(moviesList.isEmpty == false, "search should not get any result")

        XCTAssert(moviesList[title3index].rating > moviesList[title2index].rating,
                  " search result should be orderd by top 5 rating in same year ")

        XCTAssert(title3index < title2index, " search result should be orderd by top 5 rating in same year ")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
