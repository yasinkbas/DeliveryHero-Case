//
//  MovieListSearchResultPresenterTests.swift
//  MovieModuleTests
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import XCTest
@testable import MovieModule

extension MovieListSearchResultPresenterTests {
    enum Dummy {
        static let movieWidgetItem: MovieListSearchResultWidgetItem = .init(
            title: "Movies",
            height: 400,
            widgetType: .movie,
            result: [
                DummyCoverPosterCardShowableModel(
                    coverPosterId: 1,
                    coverPosterTitle: "Prey",
                    coverPosterSubtitle: "2022-08-02",
                    coverPosterImagePath: "https://image.tmdb.org/t/p/w500/7ZO9yoEU2fAHKhmJWfAc2QIPWJg.jpg"
                ),
                DummyCoverPosterCardShowableModel(
                    coverPosterId: 2,
                    coverPosterTitle: "Thor: Love and Thunder",
                    coverPosterSubtitle: "2022-07-06",
                    coverPosterImagePath: "https://image.tmdb.org/t/p/w500/p1F51Lvj3sMopG948F5HsBbl43C.jpg"
                )
            ]
        )
    }
}

final class MovieListSearchResultPresenterTests: XCTestCase {
    var presenter: MovieListSearchResultPresenter!
    var router: MockMovieListSearchResultRouter!
    var view: MockMovieListSearchResultView!
    var delegate: MockMovieListSearchResultPresenterDelegate!
    
    override func setUp() {
        super.setUp()
        reCreate()
    }
    
    private func reCreate(widgets: [MovieListSearchResultWidgetItem] = [], screenWidth: Double = 400) {
        router = .init()
        view = .init()
        delegate = .init()
        presenter = .init(view: view,
                          router: router,
                          arguments: .init(delegate: delegate,
                                           widgets: widgets),
                          screenWidth: screenWidth)
    }
    
    func test_minimumInteritemSpacingForSectionAt_ReturnsCorrectValue() {
        XCTAssertEqual(presenter.minimumInteritemSpacingForSectionAt, 10)
    }
    
    func test_numberOfItemsInSection_EmptyWidgets_ReturnsCorrectValue() {
        reCreate(widgets: [])
        XCTAssertEqual(presenter.numberOfItemsInSection, 0)
    }
    
    func test_numberOfItemsInSection_FilledWidgets_ReturnsCorrectValue() {
        reCreate(widgets: [Dummy.movieWidgetItem, Dummy.movieWidgetItem])
        XCTAssertEqual(presenter.numberOfItemsInSection, 2)
    }
    
    func test_viewDidLoad_InvokesRequiredMethods() {
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.invokedPrepareUI)
    }
    
    func test_sizeOfCell_ReturnsCorrectValue() {
        reCreate(widgets: [Dummy.movieWidgetItem, Dummy.movieWidgetItem], screenWidth: 500)
        
        let size = presenter.sizeOfCell(for: .init(item: 0, section: 0))
        XCTAssertEqual(size.width, 500)
        XCTAssertEqual(size.height, 400)
    }
    
    func test_movieListSearchResultCellArguments_ReturnsCorrectValue() {
        reCreate(widgets: [Dummy.movieWidgetItem, Dummy.movieWidgetItem], screenWidth: 500)
        
        let arguments = presenter.movieListSearchResultCellArguments(for: .init(item: 0, section: 0))
        XCTAssertEqual(arguments.widget.title, "Movies")
        XCTAssertEqual(arguments.widget.height, 400)
        XCTAssertEqual(arguments.widget.result.first?.coverPosterId, 1)
        XCTAssertEqual(arguments.widget.result.first?.coverPosterTitle, "Prey")
        XCTAssertEqual(arguments.widget.result.first?.coverPosterSubtitle, "2022-08-02")
        XCTAssertEqual(arguments.widget.result.first?.coverPosterImagePath, "https://image.tmdb.org/t/p/w500/7ZO9yoEU2fAHKhmJWfAc2QIPWJg.jpg")
        XCTAssertEqual(arguments.widget.widgetType, .movie)
    }
    
    func test_navigateToPersonDetail_InvokesRouterNavigateToPersonDetailMethod() {
        presenter.navigateToPersonDetail(with: 2)
        
        XCTAssertTrue(router.invokedNavigateToPersonDetail)
        XCTAssertEqual(router.invokedNavigateToPersonDetailParameters?.id, 2)
    }
    
    func test_navigateToMovieDetail_InvokesRouterNavigateToMovieDetailMethod() {
        presenter.navigateToMovieDetail(with: 2)
        
        XCTAssertTrue(router.invokedNavigateToMovieDetail)
        XCTAssertEqual(router.invokedNavigateToMovieDetailParameters?.id, 2)
    }
}
