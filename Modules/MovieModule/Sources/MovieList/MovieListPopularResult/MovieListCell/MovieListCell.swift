//
//  MovieListCellViewController.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit
import CommonKit

protocol MovieListCellViewInterface: AnyObject {
    func prepareUI()
    func setCoverImageView(path: String)
    func setMovieTitleLabel(text: String)
    func setMovieReleaseDateLabel(text: String)
}

extension MovieListCell {
    enum Constants {
        static let cornerRadius: CGFloat = 16
        static let placeHolderImage: UIImage = UIImage(named: "moviePlaceholder", in: .module, compatibleWith: nil)!
    }
}

final class MovieListCell: UICollectionViewCell {
    var presenter: MovieListCellPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var movieDescriptionContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        return label
    }()
    
    private lazy var movieReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        return label
    }()
}

// MARK: - MovieListCellViewInterface
extension MovieListCell: MovieListCellViewInterface {
    func prepareUI() { 
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = true
        backgroundColor = Colors.light
        
        addSubview(coverImageView)
        coverImageView.set(
            .leadingOf(self),
            .topOf(self),
            .trailingOf(self),
            .heightMultiple(self.width, 1.5)
        )
        
        addSubview(movieDescriptionContainerStackView)
        movieDescriptionContainerStackView.set(
            .leadingOf(self, 8),
            .top(coverImageView.bottom, 8),
            .trailingOf(self, 8),
            .bottomOf(self, 8)
        )
        
        movieDescriptionContainerStackView.addArrangedSubview(movieTitleLabel)
        movieDescriptionContainerStackView.addArrangedSubview(movieReleaseDateLabel)
        
    }
    
    func setCoverImageView(path: String) {
        coverImageView.setImage(path: path, placeholder: Constants.placeHolderImage)
    }
    
    func setMovieTitleLabel(text: String) {
        movieTitleLabel.text = text
    }
    
    func setMovieReleaseDateLabel(text: String) {
        movieReleaseDateLabel.text = text
    }
}
