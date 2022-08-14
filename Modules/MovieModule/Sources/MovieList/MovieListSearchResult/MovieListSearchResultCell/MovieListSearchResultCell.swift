//
//  MovieListSearchResultCell.swift
//  MovieModule
//
//  Created by Yasin Akbas on 13.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit
import CommonKit
import CommonViewsKit

protocol MovieListSearchResultCellInterface: AnyObject {
    func prepareUI()
    func setTitleLabel(text: String)
}

private extension MovieListSearchResultCell {
    enum Constants {
        static let collectionViewInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

final class MovieListSearchResultCell: UICollectionViewCell {
    var presenter: MovieListSearchResultCellPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var headerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.background
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: flowLayout)
        flowLayout.scrollDirection = .horizontal
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: CoverPosterCardCell.self, bundle: .module)
        return collectionView
    }()
}

// MARK: - MovieListSearchResultCellInterface
extension MovieListSearchResultCell: MovieListSearchResultCellInterface {
    func prepareUI() { 
        addSubview(headerContainerView)
        headerContainerView.set(.leadingOf(self), .topOf(self), .trailingOf(self), .height(30))
        
        headerContainerView.addSubview(titleLabel)
        titleLabel.set(.leadingOf(headerContainerView, 8), .centerYOf(headerContainerView))
        
        addSubview(collectionView)
        collectionView.set(.leadingOf(self), .top(headerContainerView.bottom), .trailingOf(self), .bottomOf(self))
    }
    
    func setTitleLabel(text: String) {
        titleLabel.text = text
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieListSearchResultCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = presenter.sizeOfCell
        return .init(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        presenter.minimumInteritemSpacingForSectionAt
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        Constants.collectionViewInsets
    }
}

// MARK: - UICollectionViewDataSource
extension MovieListSearchResultCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: CoverPosterCardCell.self, for: indexPath)
        cell.presenter = CoverPosterCardCellPresenter(view: cell,
                                                      model: presenter.coverPosterCardCellModel(for: indexPath))
        return cell
    }
}

