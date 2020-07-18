//
//  MoviesDetailsViewModelTest.swift
//  DecadeOfMoviesTests
//
//  Created by Bassem Abbas on 7/18/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import XCTest
@testable import DecadeOfMovies

class MoviesDetailsViewModelTest: XCTestCase {

    var sut: MoviesDetailsViewModel!
    override func setUpWithError() throws {
        sut = DefaultMoviesDetailsViewModel(movie: Movie.stubs()[0], photosUseCase: MovieDetailPhotoUseCaseMock())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchPhotos_Sucess() throws {
        let state = sut.state.value
        switch state {
            case .full(photos: let loaded):
                
            XCTAssert(loaded == true, "Photos should be loaded")
            
            default:
             XCTAssertTrue(false, "viewmodel state should be changed")
        }
    }
    
    func testRetrivePhoto_Sucess() throws {
        let photo = sut.photoItem(for: IndexPath(item: 50, section: 1))
        
        XCTAssert(photo.url.isEmpty == false)
    }
}
