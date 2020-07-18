//
//  MoviesRepositoryTest.swift
//  DecadeOfMoviesTests
//
//  Created by Bassem Abbas on 7/18/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import XCTest
@testable import DecadeOfMovies

class MoviesRepositoryTest: XCTestCase {

    var sut: DefaultMoviesRepository!
    
    override func setUpWithError() throws {
       sut = DefaultMoviesRepository(local: JSONMoviesResponseStorage())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoadFullData() throws {
        // This is an example of a performance test case.
        self.measure {
            sut.fetchMoviesList { (result) in
                let list = result.value
                
                XCTAssertTrue(list?.count ?? 0 > 2000 )
            }
        }
    }

}
