//
//  MovieListPopularResultPresenterTests.swift.swift
//  MovieModuleTests
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import XCTest
import NetworkManagerKit
import CommonKit
@testable import MovieModule

final class MovieListPopularResultPresenterTests: XCTestCase {
    var presenter: MovieListPopularResultPresenter!
    var view: MockMovieListPopularResultView!
    var router: MockMovieListPopularResultRouter!
    var delegate: MockMovieListPopularResultPresenterDelegate!
    
    override func setUp() {
        super.setUp()
        reCreate(screenWidth: 400)
    }
    
    private func reCreate(screenWidth: Double) {
        view = .init()
        router = .init()
        delegate = .init()
        presenter = .init(view: view, router: router, arguments: .init(delegate: delegate), screenWidth: screenWidth)
    }
    
    func test_sizeOfCell_ReturnsCorrectValues() {
        reCreate(screenWidth: 400)
        XCTAssertEqual(presenter.sizeOfCell.width, 180)
        XCTAssertEqual(presenter.sizeOfCell.height, 320)
    }
    
    func test_minimumInteritemSpacingForSectionAt_ReturnsCorrectValue() {
        XCTAssertEqual(presenter.minimumInteritemSpacingForSectionAt, 20)
    }
    
    func test_numberOfItemsInSection_MoviesIsEmpty_ReturnsZero() {
        XCTAssertEqual(presenter.numberOfItemsInSection, 0)
    }
    
    func test_numberOfItemsInSection_MoviesIsFilled_ReturnsMoviesCount() {
        presenter.addNewMovies(response: popularMoviesResponse)
        XCTAssertEqual(presenter.numberOfItemsInSection, 20)
    }
    
    func test_viewDidLoad_InvokesRequiredMethods() {
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.invokedPrepareUI)
    }
    
    func test_willDisplayCell_LastPage_NotInvokeDelegateFetchPopularMoviesMethod() {
        presenter.addNewMovies(response: popularMoviesLastPageResponse)
        
        presenter.willDisplayCell(indexPath: .init(item: 16, section: 0))
        
        XCTAssertFalse(delegate.invokedMovieListPopularResultFetchPopularMovies)
    }
    
    func test_willDisplayCell_FirstPage_InvokesDelegateFetchPopularMoviesMethod() {
        presenter.addNewMovies(response: popularMoviesFirstPageResponse)
        
        presenter.willDisplayCell(indexPath: .init(item: 16, section: 0))
        
        XCTAssertTrue(delegate.invokedMovieListPopularResultFetchPopularMovies)
        XCTAssertEqual(delegate.invokedMovieListPopularResultFetchPopularMoviesParameters?.page, 2)
    }
    
    func test_movieCellPresenterArguments_ReturnsCorrectValue() {
        presenter.addNewMovies(response: popularMoviesResponse)
        
        let arguments0 = presenter.movieCellPresenterArguments(for: .init(item: 0, section: 0))
        XCTAssertEqual(arguments0.title, "Prey")
        XCTAssertEqual(arguments0.secondaryTitle, "2022-08-02")
        XCTAssertEqual(arguments0.imageUrl, "https://image.tmdb.org/t/p/w500/7ZO9yoEU2fAHKhmJWfAc2QIPWJg.jpg")
        
        let arguments1 = presenter.movieCellPresenterArguments(for: .init(item: 1, section: 0))
        XCTAssertEqual(arguments1.title, "Thor: Love and Thunder")
        XCTAssertEqual(arguments1.secondaryTitle, "2022-07-06")
        XCTAssertEqual(arguments1.imageUrl, "https://image.tmdb.org/t/p/w500/p1F51Lvj3sMopG948F5HsBbl43C.jpg")
    }
    
    func test_didSelectItemAt_InvokesNavigateToMovieDetailMethod() {
        presenter.addNewMovies(response: popularMoviesResponse)
        
        presenter.didSelectItemAt(indexPath: .init(item: 0, section: 0))
        
        XCTAssertTrue(router.invokedNavigateToMovieDetail)
        XCTAssertEqual(router.invokedNavigateToMovieDetailParameters?.id, 766507)
    }
    
    func test_addNewMovies_InvokesRelatedMethods() {
        presenter.addNewMovies(response: popularMoviesResponse)
        
        XCTAssertTrue(view.invokedReloadData)
    }
}

extension MovieListPopularResultPresenterTests {
    var bundle: Bundle { .init(for: Self.self) }
    
    var popularMoviesResponse: MovieListAPIResponse {
        JSONParser.decode(for: MovieListAPIResponse.self,
                          fileName: "PopularMoviesResponse",
                          bundle: bundle)
    }
    
    var popularMoviesLastPageResponse: MovieListAPIResponse {
        JSONParser.decode(for: MovieListAPIResponse.self,
                          fileName: "PopularMoviesLastPageResponse",
                          bundle: bundle)
    }
    
    var popularMoviesFirstPageResponse: MovieListAPIResponse {
        JSONParser.decode(for: MovieListAPIResponse.self,
                          fileName: "PopularMoviesFirstPageResponse",
                          bundle: bundle)
    }
}


