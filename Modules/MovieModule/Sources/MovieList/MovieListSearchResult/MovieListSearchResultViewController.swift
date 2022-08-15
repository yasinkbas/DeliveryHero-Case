//
//  MovieListSearchResultViewController.swift
//  MovieModule
//
//  Created by Yasin Akbas on 13.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit
import CommonKit

protocol MovieListSearchResultViewInterface: AnyObject {
    func prepareUI()
}

extension MovieListSearchResultViewController {
    enum Configs {
        enum CollectionView {

        }
    }
}

extension MovieListSearchResultViewController {
    enum Constants {
        static let title: String = "Search Results"
        static let collectionViewInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

class MovieListSearchResultViewController: UIViewController {
    var presenter: MovieListSearchResultPresenterInterface!
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.title
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var headerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.background
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: MovieListSearchResultCell.self, bundle: .module)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - MovieListSearchResultViewInterface
extension MovieListSearchResultViewController: MovieListSearchResultViewInterface { 
    func prepareUI() { 
        view.backgroundColor = Colors.background
        
        view.addSubview(headerContainerView)
        headerContainerView.set(.leadingOf(view), .topOf(view), .trailingOf(view), .height(40))
        
        headerContainerView.addSubview(titleLabel)
        titleLabel.set(.leadingOf(headerContainerView, 8), .centerYOf(headerContainerView))
        
        view.addSubview(collectionView)
        collectionView.set(.leadingOf(view), .top(headerContainerView.bottom), .trailingOf(view), .bottomOf(view))
    }
}

// MARK: - UICollectionViewDataSource
extension MovieListSearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: MovieListSearchResultCell.self, for: indexPath)
        let arguments = presenter.movieListSearchResultCellArguments(for: indexPath)
        cell.presenter = MovieListSearchResultCellPresenter(view: cell, arguments: arguments)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieListSearchResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = presenter.sizeOfCell(for: indexPath)
        return .init(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        presenter.minimumInteritemSpacingForSectionAt
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        Constants.collectionViewInsets
    }
}
