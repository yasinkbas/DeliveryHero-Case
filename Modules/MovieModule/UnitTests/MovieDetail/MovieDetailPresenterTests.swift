//
//  MovieDetailPresenterTests.swift
//  MovieModule
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

@testable import MovieModule
import XCTest

final class MovieDetailPresenterTests: XCTestCase {
    var interactor: MockMovieDetailInteractor!
    var router: MockMovieDetailRouter!
    var view: MockMovieDetailView!
    var presenter: MovieDetailPresenter!
    
    override func setUp() {
        super.setUp()
        reCreate(with: 1)
    }
    
    private func reCreate(with id: Int) {
        interactor = .init()
        router = .init()
        view = .init()
        presenter = .init(view: view,
                          router: router,
                          interactor: interactor,
                          arguments: .init(id: id))
    }
    
    func test_emptyViewMessage_ReturnsCorrectValue() {
        XCTAssertEqual(presenter.emptyViewMessage, "Test - ID(1) Movie Detail Page")
    }
    
    func test_viewDidLoad_InvokesRequiredMethods() {
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.invokedPrepareUI)
        XCTAssertTrue(view.invokedShowEmptyView)
    }
}
