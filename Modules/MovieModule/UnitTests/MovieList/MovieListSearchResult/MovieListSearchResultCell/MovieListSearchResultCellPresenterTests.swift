//
//  MovieListSearchResultCellPresenterTests.swift
//  MovieModuleTests
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import XCTest
@testable import MovieModule

extension MovieListSearchResultCellPresenterTests {
    enum Dummy {
        static let defaultWidgetItem: MovieListSearchResultWidgetItem = .init(
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
        
        static let peopleWidgetItem: MovieListSearchResultWidgetItem = .init(
            title: "People",
            height: 400,
            widgetType: .people,
            result: [
                DummyCoverPosterCardShowableModel(
                    coverPosterId: 1,
                    coverPosterTitle: "Steven",
                    coverPosterSubtitle: "Popularity: 848",
                    coverPosterImagePath: "https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg"
                )
            ]
        )
    }
}

final class MovieListSearchResultCellPresenterTests: XCTestCase {
    var presenter: MovieListSearchResultCellPresenter!
    var view: MockMovieListSearchResultCellView!
    var delegate: MockMovieListSearchResultCellPresenterDelegate!
    
    override func setUp() {
        super.setUp()
        reCreate()
    }
    
    private func reCreate(widget: MovieListSearchResultWidgetItem = Dummy.defaultWidgetItem) {
        view = .init()
        delegate = .init()
        presenter = .init(view: view, arguments: .init(widget: widget, delegate: delegate))
    }
    
    func test_sizeOfCell_DefaultWidget_ReturnsCorrectValue() {
        reCreate(widget: Dummy.defaultWidgetItem)
        
        let size = presenter.sizeOfCell
        XCTAssertEqual(size.height, 360)
        XCTAssertEqual(size.width, 140)
    }
    
    func test_sizeOfCell_PeopleWidget_ReturnsCorrectValue() {
        reCreate(widget: Dummy.peopleWidgetItem)
        
        let size = presenter.sizeOfCell
        XCTAssertEqual(size.height, 350.0)
        XCTAssertEqual(size.width, 100.0)
    }
    
    func test_minimumInteritemSpacingForSectionAt_ReturnsCorrectValue() {
        XCTAssertEqual(presenter.minimumInteritemSpacingForSectionAt, 10)
    }
    
    func test_numberOfItemsInSection_ReturnsCorrectValue() {
        reCreate(widget: Dummy.defaultWidgetItem)
        XCTAssertEqual(presenter.numberOfItemsInSection, 2)
    }
    
    func test_load_InvokesRequiredMethods() {
        reCreate(widget: Dummy.defaultWidgetItem)
        
        presenter.load()
        
        XCTAssertTrue(view.invokedPrepareUI)
        XCTAssertTrue(view.invokedSetTitleLabel)
        XCTAssertEqual(view.invokedSetTitleLabelParameters?.text, "Movies")
    }
    
    func test_coverPosterCardCellModel_ReturnsCorrectValue() {
        reCreate(widget: Dummy.defaultWidgetItem)
        
        let model = presenter.coverPosterCardCellModel(for: .init(item: 1, section: 0))
        
        XCTAssertEqual(model.coverPosterId, 2)
        XCTAssertEqual(model.coverPosterTitle, "Thor: Love and Thunder")
        XCTAssertEqual(model.coverPosterSubtitle, "2022-07-06")
        XCTAssertEqual(model.coverPosterImagePath, "https://image.tmdb.org/t/p/w500/p1F51Lvj3sMopG948F5HsBbl43C.jpg")
    }
    
    func test_didSelectItemAt_PeopleWidget_InvokesNavigateToPersonDetail() {
        reCreate(widget: Dummy.peopleWidgetItem)
        
        presenter.didSelectItemAt(indexPath: .init(item: 0, section: 0))
        
        XCTAssertTrue(delegate.invokedNavigateToPersonDetail)
        XCTAssertEqual(delegate.invokedNavigateToPersonDetailParameters?.id, 1)
        XCTAssertFalse(delegate.invokedNavigateToMovieDetail)
    }
    
    func test_didSelectItemAt_DefaultWidget_InvokesNavigateToPersonDetail() {
        reCreate(widget: Dummy.defaultWidgetItem)
        
        presenter.didSelectItemAt(indexPath: .init(item: 1, section: 0))
        
        XCTAssertFalse(delegate.invokedNavigateToPersonDetail)
        XCTAssertTrue(delegate.invokedNavigateToMovieDetail)
        XCTAssertEqual(delegate.invokedNavigateToMovieDetailParameters?.id, 2)
    }
}
