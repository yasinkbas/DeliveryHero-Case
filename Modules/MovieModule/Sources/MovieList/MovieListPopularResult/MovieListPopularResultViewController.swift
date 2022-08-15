//
//  MovieListPopularResultViewController.swift
//  MovieModule
//
//  Created by Yasin Akbas on 12.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit
import CommonKit
import CommonViewsKit

protocol MovieListPopularResultViewInterface: AnyObject {
    func prepareUI()
    func reloadData()
}

final class MovieListPopularResultViewController: UIViewController {
    var presenter: MovieListPopularResultPresenterInterface!
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular Movies"
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
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: CoverPosterCardCell.self, bundle: .module)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - MovieListPopularResultViewInterface
extension MovieListPopularResultViewController: MovieListPopularResultViewInterface { 
    func prepareUI() {
        view.addSubview(headerContainerView)
        headerContainerView.set(.leadingOf(view), .topOf(view), .trailingOf(view), .height(40))
        
        headerContainerView.addSubview(titleLabel)
        titleLabel.set(.leadingOf(headerContainerView, 8), .centerYOf(headerContainerView))
        
        view.addSubview(collectionView)
        collectionView.set(.leadingOf(view), .top(headerContainerView.bottom), .trailingOf(view), .bottomOf(view))
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension MovieListPopularResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: presenter.sizeOfCell.width, height: presenter.sizeOfCell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        presenter.minimumInteritemSpacingForSectionAt
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.willDisplayCell(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(indexPath: indexPath)
    }
}

// MARK: - UICollectionViewDataSource
extension MovieListPopularResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: CoverPosterCardCell.self, for: indexPath)
        let arguments = presenter.movieCellPresenterArguments(for: indexPath)
        cell.presenter = CoverPosterCardCellPresenter(view: cell, arguments: arguments)
        return cell
    }
}

