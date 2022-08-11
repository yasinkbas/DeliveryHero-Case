//
//  MovieListCellViewController.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit

protocol MovieListCellViewInterface: AnyObject {
    func prepareUI()
}

extension MovieListCell {
    enum Constants {
        static let cornerRadius: CGFloat = 16
    }
}

class MovieListCell: UICollectionViewCell {
    var presenter: MovieListCellPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
}

// MARK: - MovieListCellViewInterface
extension MovieListCell: MovieListCellViewInterface { 
    func prepareUI() { 
        layer.cornerRadius = Constants.cornerRadius
    }
}
