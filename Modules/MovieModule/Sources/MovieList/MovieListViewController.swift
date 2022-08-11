//
//  MovieListViewController.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit
import CommonKit

protocol MovieListViewInterface: EmptyViewShowable {
    func prepareUI()
    func prepareHeaderView(height: Double)
}

private extension MovieListViewController {
    enum Constants {
        enum EmptyView {
            static let message: String = "No results found"
            static let titleColor: UIColor = .white
            static let titleFontSize: CGFloat = 18
        }
        
        enum HeaderView {
            static let height: CGFloat = 100
        }
    }
}

class MovieListViewController: UIViewController {
    var presenter: MovieListPresenterInterface!
    
    private lazy var headerView: MovieListHeaderView = {
        let headerView = MovieListHeaderView()
        return headerView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
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
        view.addSubview(collectionView)
        collectionView.set(.leadingOf(view),
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
}

// MARK: - UICollectionViewDelegate
extension MovieListViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as? UICollectionViewCell else { return UICollectionViewCell()
        }
        cell.backgroundColor = .purple
        return cell
    }
    
    
}
