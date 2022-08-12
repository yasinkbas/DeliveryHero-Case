//
//  MovieListPopularResultViewController.swift
//  MovieModule
//
//  Created by Yasin Akbas on 12.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit

protocol MovieListPopularResultViewInterface: AnyObject {
    func prepareUI()
    func reloadData()
}

class MovieListPopularResultViewController: UIViewController {
    var presenter: MovieListPopularResultPresenterInterface!
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: MovieListCell.self, bundle: .module)
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
        view.addSubview(collectionView)
        collectionView.set(.leadingOf(view),
            .topOf(view),
            .trailingOf(view),
            .bottomOf(view)
        )
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
}

// MARK: - UICollectionViewDelegate
extension MovieListPopularResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.willDisplayCell(indexPath: indexPath)
    }
}

// MARK: - UICollectionViewDataSource
extension MovieListPopularResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: MovieListCell.self, for: indexPath)
        cell.presenter = MovieListCellPresenter(view: cell)
        cell.backgroundColor = .purple
        return cell
    }
}

