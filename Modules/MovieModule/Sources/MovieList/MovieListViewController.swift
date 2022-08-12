//
//  MovieListViewController.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit
import CommonKit
import CoreViewsKit

protocol MovieListViewInterface: EmptyViewShowable, LoadingShowable {
    func prepareUI()
    func prepareHeaderView(height: Double)
    func showMovieListPopularResult(with arguments: MovieListPopularResultPresenterArguments) -> MovieListPopularResultModule
}

private extension MovieListViewController {
    enum Constants {
        enum EmptyView {
            static let message: String = "No results found"
            static let titleColor: UIColor = .white
            static let titleFontSize: CGFloat = 18
        }
        
        enum HeaderView {
            static let initialHeight: CGFloat = 100
        }
    }
}

class MovieListViewController: UIViewController {
    var presenter: MovieListPresenterInterface!
    
    private lazy var headerView: MovieListHeaderView = {
        let headerView = MovieListHeaderView()
        return headerView
    }()
    
    private lazy var contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

// MARK: - MovieListViewInterface
extension MovieListViewController: MovieListViewInterface {
    var emptyViewPaddings: UIEdgeInsets {
        let topInset = headerView.get(.height).first?.constant ?? .zero
        return .init(top: topInset, left: 0, bottom: 0, right: 0)
    }
    
    var emptyViewArguments: EmptyViewPresenterArguments {
        .init(
            message: Constants.EmptyView.message,
            titleColor: Constants.EmptyView.titleColor,
            titleFontSize: Constants.EmptyView.titleFontSize
        )
    }
    
    func prepareUI() { 
        view.backgroundColor = Colors.background
        
        view.addSubview(headerView)
        headerView.set(
            .leadingOf(view),
            .topOf(view),
            .trailingOf(view)
        )
        
        view.addSubview(contentContainerView)
        contentContainerView.set(
            .leadingOf(view),
            .top(headerView.bottom),
            .trailingOf(view),
            .bottomOf(view)
        )
    }
    
    func prepareHeaderView(height: Double) {
        let presenter = MovieListHeaderPresenter(view: headerView,
                                                 delegate: presenter.movieListHeaderPresenterDelegate)
        headerView.presenter = presenter
        headerView.set(.height(height))
    }
    
    func showMovieListPopularResult(with arguments: MovieListPopularResultPresenterArguments) -> MovieListPopularResultModule {
        let (movieListPopularResultView, movieListPopularResultModule) = MovieListPopularResultRouter.createModule(arguments: arguments)
        embed(movieListPopularResultView, in: contentContainerView)
        return movieListPopularResultModule
    }
}
