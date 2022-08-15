//
//  MovieListHeaderPresenterTests.swift
//  MovieModule
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

@testable import MovieModule
import XCTest

final class MovieListHeaderPresenterTests: XCTestCase {
    var presenter: MovieListHeaderPresenter!
    var view: MockMovieListHeaderView!
    var delegate: MockMovieListHeaderPresenterDelegate!
    
    override func setUp() {
        super.setUp()
        view = .init()
        delegate = .init()
        presenter = .init(view: view, delegate: delegate)
    }
    
    func test_load_InvokesRequiredMethods() {
        presenter.load()
        
        XCTAssertTrue(view.invokedPrepareUI)
    }
    
    func test_doneIconTapped_EmptySearchText_InvokesRelatedMethods() {
        presenter.doneIconTapped()
        
        XCTAssertTrue(delegate.invokedMovieListHeaderSearchButtonTapped)
        XCTAssertEqual(delegate.invokedMovieListHeaderSearchButtonTappedParameters?.searchText, "")
    }
    
    func test_doneIconTapped_FilledSearchText_InvokesRelatedMethods() {
        presenter.searchTextFieldDidChange("Steven")
        
        presenter.doneIconTapped()
        
        XCTAssertTrue(delegate.invokedMovieListHeaderSearchButtonTapped)
        XCTAssertEqual(delegate.invokedMovieListHeaderSearchButtonTappedParameters?.searchText, "Steven")
    }
    
    func test_searchContainerViewTapped_searchIconExpandedFalse_InvokesRelatedMethods() {
        presenter.searchContainerViewTapped()
        
        XCTAssertFalse(view.invokedHideSearchTextField)
        XCTAssertFalse(view.invokedSetTextField)
        XCTAssertFalse(delegate.invokedMovieListHeaderShrinkButtonTapped)
        XCTAssertTrue(view.invokedShowSearchTextField)
    }
    
    func test_searchContainerViewTapped_searchIconExpandedTrue_InvokesRelatedMethods() {
        presenter.searchContainerViewTapped()
        
        // reset values
        view.invokedHideSearchTextField = false
        view.invokedSetTextField = false
        delegate.invokedMovieListHeaderShrinkButtonTapped = false
        view.invokedShowSearchTextField = false
        
        presenter.searchContainerViewTapped()
        
        XCTAssertTrue(view.invokedHideSearchTextField)
        XCTAssertTrue(view.invokedSetTextField)
        XCTAssertTrue(delegate.invokedMovieListHeaderShrinkButtonTapped)
        XCTAssertFalse(view.invokedShowSearchTextField)
    }
    
    func test_searchTextFieldDidChange_UpdatesSearchText() {
        presenter.searchTextFieldDidChange("Steven")
        presenter.doneIconTapped()
        
        XCTAssertEqual(delegate.invokedMovieListHeaderSearchButtonTappedParameters?.searchText, "Steven")
    }
}
