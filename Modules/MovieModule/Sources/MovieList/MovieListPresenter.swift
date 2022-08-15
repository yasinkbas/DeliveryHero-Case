//
//  MovieListPresenter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import CommonKit
import NetworkManagerKit

protocol MovieListPresenterInterface: AnyObject {
    var movieListHeaderPresenterDelegate: MovieListHeaderPresenterDelegate { get }
    
    func viewDidLoad()
}

private extension MovieListPresenter {
    enum Constants {
        static let headerViewHeightSmallDevices: Double = 70
        static let headerViewHeightBigDevices: Double = 120
        
        static let popularMoviesFetchInitialPageNumber: Int = 1
        static let searchMoviesInitialPageNumber: Int = 1
        static let searchPeopleInitialPageNumber: Int = 1
        static let searchGenreMoviesInitialPageNumber: Int = 1
        
        static let noResultAlertMessage: String = "No results found"
        enum Widget {
            enum Movie {
                static let title: String = "Movies"
                static let height: Double = 300
            }
            
            enum Genre {
                static let title: String = "Genre Movies"
                static let height: Double = 300
            }
            
            enum People {
                static let title: String = "People"
                static let height: Double = 245
            }
        }
    }
}

private extension MovieListPresenter {
    enum State {
        case empty, listPopular, search, loading
    }
}

final class MovieListPresenter {
    private weak var view: MovieListViewInterface?
    private let router: MovieListRouterInterface
    private let interactor: MovieListInteractorInterface
    private let isIphoneXOrBigger: Bool
    private var genresResponse: GenresResponse?
    
    private var movieListPopularResultModule: MovieListPopularResultModule?
    private var movieListSearchResultModule: MovieListSearchResultModule?
    
    private let searchRequestsDispatchGroup: DispatchGroup = .init()
    private var movieSearchResultResponse: MovieSearchResultAPIResponse?
    private var peopleSearchResultResponse: PeopleSearchResultAPIResponse?
    private var genreMoviesSearchResultResponse: GenreMoviesSearchResultAPIResponse?
    
    private var state: State = .empty {
        didSet {
            updateUI()
        }
    }
    
    init(
        view: MovieListViewInterface,
        router: MovieListRouterInterface,
        interactor: MovieListInteractorInterface,
        isIphoneXOrBigger: Bool = Device.isIphoneXOrBigger
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.isIphoneXOrBigger = isIphoneXOrBigger
    }
    
    private func updateUI() {
        switch state {
        case .empty:
            view?.hideLoading()
            view?.showEmptyView()
        case .listPopular:
            view?.hideLoading()
            view?.hideEmptyView()
            view?.hideMovieListSearchResult()
        case .search:
            view?.hideLoading()
            view?.hideEmptyView()
        case .loading:
            view?.showLoading()
            view?.hideEmptyView()
        }
    }
    
    private func fetchPopularMovies(page: Int) {
        state = .loading
        interactor.fetchPopularMovies(page: Constants.popularMoviesFetchInitialPageNumber)
    }
    
    private func fetchGenres() {
        state = .loading
        interactor.fetchMovieGenres()
    }
    
    private func searchMovies(page: Int, query: String) {
        searchRequestsDispatchGroup.enter()
        interactor.searchMovies(page: page, query: query)
    }
    
    private func searchPeople(page: Int, query: String) {
        searchRequestsDispatchGroup.enter()
        interactor.searchPeople(page: page, query: query)
    }
    
    private func searchGenreMovies(page: Int, genreId: Int) {
        searchRequestsDispatchGroup.enter()
        interactor.searchGenreMovies(page: page, genreId: genreId)
    }
    
    private func prepareSearchWidgetItems() {
        var widgets: [MovieListSearchResultWidgetItem] = []
        if let movieSearchResult = movieSearchResultResponse?.results,
            !movieSearchResult.isEmpty {
            widgets.append(.init(title: Constants.Widget.Movie.title,
                                 height: Constants.Widget.Movie.height,
                                 widgetType: .movie,
                                 result: movieSearchResult))
        }
        
        if let genreMoviesSearchResult = genreMoviesSearchResultResponse?.results,
           !genreMoviesSearchResult.isEmpty {
            widgets.append(.init(title: Constants.Widget.Genre.title,
                                 height: Constants.Widget.Genre.height,
                                 widgetType: .genre,
                                 result: genreMoviesSearchResult))
        }
        
        if let peopleSearchResult = peopleSearchResultResponse?.results,
            !peopleSearchResult.isEmpty {
            widgets.append(.init(title: Constants.Widget.People.title,
                                 height: Constants.Widget.People.height,
                                 widgetType: .people,
                                 result: peopleSearchResult))
        }
        
        guard !widgets.isEmpty else {
            state = .listPopular
            view?.showAlert(message: Constants.noResultAlertMessage)
            return
        }
        state = .search
        movieListSearchResultModule = view?.prepareMovieListSearchResult(with: .init(delegate: self, widgets: widgets))
    }
}

// MARK: - MovieListPresenterInterface
extension MovieListPresenter: MovieListPresenterInterface {
    var movieListHeaderPresenterDelegate: MovieListHeaderPresenterDelegate { self }
    
    func viewDidLoad() {
        view?.prepareUI()
        view?.prepareHeaderView(
            height: isIphoneXOrBigger
            ? Constants.headerViewHeightBigDevices
            : Constants.headerViewHeightSmallDevices
        )
        fetchGenres()
        fetchPopularMovies(page: Constants.popularMoviesFetchInitialPageNumber)
    }
}

// MARK: - MovieListInteractorOutput
extension MovieListPresenter: MovieListInteractorOutput {
    func handleFetchPopularMoviesResponse(response: MovieListAPIResponse) {
        guard !response.results.isEmpty else {
            state = .empty
            return
        }
        if movieListPopularResultModule == nil {
            movieListPopularResultModule = view?.prepareMovieListPopularResult(with: .init(delegate: self))
        }
        movieListPopularResultModule?.addNewMovies(response: response)
        state = .listPopular
    }
    
    func handleFetchGenreListResponse(response: GenresResponse) {
        genresResponse = response
    }
    
    func handleSearchMoviesResponse(response: MovieSearchResultAPIResponse) {
        defer { searchRequestsDispatchGroup.leave() }
        movieSearchResultResponse = response
    }
    
    func handleSearchPeopleResponse(response: PeopleSearchResultAPIResponse) {
        defer { searchRequestsDispatchGroup.leave() }
        peopleSearchResultResponse = response
    }
    
    func handleSearchGenreMoviesResponse(response: GenreMoviesSearchResultAPIResponse) {
        defer { searchRequestsDispatchGroup.leave() }
        genreMoviesSearchResultResponse = response
    }
    
    func handleRequestError(error: Error) {
        view?.hideLoading()
        view?.showAlert(message: error.localizedDescription)
        state = .empty
    }
}

// MARK: - MovieListHeaderPresenterDelegate
extension MovieListPresenter: MovieListHeaderPresenterDelegate {    
    func movieListHeaderSearchButtonTapped(searchText: String) {
        guard searchText != .empty else { return }
        state = .loading
        searchMovies(page: Constants.searchMoviesInitialPageNumber, query: searchText)
        searchPeople(page: Constants.searchPeopleInitialPageNumber, query: searchText)
        if let genre = genresResponse?.genres.first(where: { $0.name.lowercased() == searchText.lowercased() }) {
            searchGenreMovies(page: Constants.searchGenreMoviesInitialPageNumber, genreId: genre.id)
        }
        searchRequestsDispatchGroup.notify(queue: .main, execute: prepareSearchWidgetItems)
    }
    
    func movieListHeaderShrinkButtonTapped() {
        state = .listPopular
        movieSearchResultResponse = nil
        peopleSearchResultResponse = nil
        genreMoviesSearchResultResponse = nil
    }
}

// MARK: - MovieListPopularResultPresenterDelegate
extension MovieListPresenter: MovieListPopularResultPresenterDelegate {
    func movieListPopularResultFetchPopularMovies(page: Int) {
        interactor.fetchPopularMovies(page: page)
    }
}

// MARK: - MovieListSearchResultPresenterDelegate
extension MovieListPresenter: MovieListSearchResultPresenterDelegate {
    func movieListSearchResultSearchMovies(page: Int, query: String) {
        // TODO: make pagination requests
        // with response update searchResult module values
    }
    
    func movieListSearchResultSearchGenreMovies(page: Int, query: String) {
        // TODO: make pagination requests
        // with response update searchResult module values
    }
    
    func movieListSearchResultSearchPeople(page: Int, query: String) {
        // TODO: make pagination requests
        // with response update searchResult module values
    }
}
