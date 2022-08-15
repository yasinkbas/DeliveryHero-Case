//
//  MovieListPresenterTests.swift
//  MovieModuleTests
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

@testable import MovieModule
import XCTest
import CommonKit

extension MovieListPresenterTests {
    enum DummyError: LocalizedError {
        case networkError
        
        var errorDescription: String? { "Dummy error message" }
    }
}

final class MovieListPresenterTests: XCTestCase {
    var presenter: MovieListPresenter!
    var interactor: MockMovieListInteractor!
    var router: MockMovieListRouter!
    var view: MockMovieListView!
    var movieListPopularResultModule: MockMovieListPopularResultModule!
    
    override func setUp() {
        super.setUp()
        reCreate(isIphoneXOrBigger: true)
    }
    
    private func reCreate(isIphoneXOrBigger: Bool) {
        interactor = .init()
        router = .init()
        view = .init()
        presenter = .init(view: view,
                          router: router,
                          interactor: interactor,
                          isIphoneXOrBigger: isIphoneXOrBigger)
        
        movieListPopularResultModule = .init()
        view.stubbedPrepareMovieListPopularResultResult = movieListPopularResultModule
    }
    
    func test_movieListHeaderPresenterDelegate_ReturnsCorrectValue() {
        XCTAssertTrue(presenter.movieListHeaderPresenterDelegate === presenter)
    }
    
    func test_viewDidLoad_IphoneXOrBigger_InvokesRelatedMethods() {
        reCreate(isIphoneXOrBigger: true)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.invokedPrepareUI)
        XCTAssertTrue(view.invokedPrepareHeaderView)
        XCTAssertEqual(view.invokedPrepareHeaderViewParameters?.height, 120)
        XCTAssertTrue(interactor.invokedFetchMovieGenres)
        XCTAssertTrue(interactor.invokedFetchPopularMovies)
        XCTAssertEqual(interactor.invokedFetchPopularMoviesParameters?.page, 1)
    }
    
    func test_viewDidLoad_NotLowerThanIphoneX_InvokesRelatedMethods() {
        reCreate(isIphoneXOrBigger: false)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.invokedPrepareUI)
        XCTAssertTrue(view.invokedPrepareHeaderView)
        XCTAssertEqual(view.invokedPrepareHeaderViewParameters?.height, 70)
        XCTAssertTrue(interactor.invokedFetchMovieGenres)
        XCTAssertTrue(interactor.invokedFetchPopularMovies)
        XCTAssertEqual(interactor.invokedFetchPopularMoviesParameters?.page, 1)
    }
    
    func test_handleFetchPopularMoviesResponse_ResultEmpty_DoesNotInvokeRelatedMethods() {
        presenter.handleFetchPopularMoviesResponse(response: popularMoviesResponseEmptyResult)
        
        XCTAssertFalse(view.invokedPrepareMovieListPopularResult)
        XCTAssertFalse(movieListPopularResultModule.invokedAddNewMovies)
    }
    
    func test_handleFetchPopularMoviesResponse_ResultFilled_InvokesRelatedMethods() {
        presenter.handleFetchPopularMoviesResponse(response: popularMoviesResponse)
        
        XCTAssertTrue(view.invokedPrepareMovieListPopularResult)
        XCTAssertTrue(view.invokedPrepareMovieListPopularResultParameters?.arguments.delegate === presenter)
        XCTAssertTrue(movieListPopularResultModule.invokedAddNewMovies)
        XCTAssertEqual(movieListPopularResultModule.invokedAddNewMoviesParameters?.response.results.first?.id, 766507)
        XCTAssertEqual(movieListPopularResultModule.invokedAddNewMoviesParameters?.response.results.first?.title, "Prey")
    }
    
    func test_handleRequestError_InvokesRequiredMethods() {
        presenter.handleRequestError(error: DummyError.networkError)
        
        XCTAssertTrue(view.invokedHideLoading)
        XCTAssertTrue(view.invokedShowAlert)
        XCTAssertEqual(view.invokedShowAlertParameters?.message, "Dummy error message")
    }
    
    func test_movieListHeaderSearchButtonTapped_SearchTextEmpty_NotInvokeRelatedMethods() {
        presenter.movieListHeaderSearchButtonTapped(searchText: "")
        
        XCTAssertFalse(interactor.invokedSearchMovies)
        XCTAssertFalse(interactor.invokedSearchPeople)
        XCTAssertFalse(interactor.invokedSearchGenreMovies)
    }
    
    func test_movieListHeaderSearchButtonTapped_SearchTextFilled_NotInvokeRelatedMethods() {
        presenter.movieListHeaderSearchButtonTapped(searchText: "Steven")
        
        XCTAssertTrue(interactor.invokedSearchMovies)
        XCTAssertEqual(interactor.invokedSearchMoviesParameters?.page, 1)
        XCTAssertTrue(interactor.invokedSearchPeople)
        XCTAssertEqual(interactor.invokedSearchPeopleParameters?.page, 1)
        XCTAssertFalse(interactor.invokedSearchGenreMovies)
    }
    
    func test_movieListHeaderSearchButtonTapped_SearchTextFilledWithGenreItem_NotInvokeRelatedMethods() {
        presenter.handleFetchGenreListResponse(response: genreListResponse)
        
        presenter.movieListHeaderSearchButtonTapped(searchText: "Horror")
        
        XCTAssertTrue(interactor.invokedSearchMovies)
        XCTAssertEqual(interactor.invokedSearchMoviesParameters?.page, 1)
        XCTAssertTrue(interactor.invokedSearchPeople)
        XCTAssertEqual(interactor.invokedSearchPeopleParameters?.page, 1)
        XCTAssertTrue(interactor.invokedSearchGenreMovies)
        XCTAssertEqual(interactor.invokedSearchGenreMoviesParameters?.page, 1)
        XCTAssertEqual(interactor.invokedSearchGenreMoviesParameters?.genreId, 27)
    }
    
    func test_movieListPopularResultFetchPopularMovies_InvokesInteractorFetchPopularMoviesMethod() {
        presenter.movieListPopularResultFetchPopularMovies(page: 2)
        
        XCTAssertTrue(interactor.invokedFetchPopularMovies)
        XCTAssertEqual(interactor.invokedFetchPopularMoviesParameters?.page, 2)
    }
}

extension MovieListPresenterTests {
    var bundle: Bundle { .init(for: Self.self) }
    
    var popularMoviesResponse: MovieListAPIResponse {
        JSONParser.decode(for: MovieListAPIResponse.self,
                          fileName: "PopularMoviesResponse",
                          bundle: bundle)
    }
    
    var popularMoviesResponseEmptyResult: MovieListAPIResponse {
        JSONParser.decode(for: MovieListAPIResponse.self,
                          fileName: "PopularMoviesResponseEmptyResult",
                          bundle: bundle)
    }
    
    var genreListResponse: GenresResponse {
        JSONParser.decode(for: GenresResponse.self,
                          fileName: "GenreListResponse",
                          bundle: bundle)
    }
}
