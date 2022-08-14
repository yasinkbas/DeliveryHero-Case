//
//  CoverPosterCardCellViewController.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit
import CommonKit

public protocol CoverPosterCardCellViewInterface: AnyObject {
    func prepareUI()
    func setCoverImageView(path: String)
    func setTitleLabel(text: String)
    func setSubtitleLabel(text: String)
}

private extension CoverPosterCardCell {
    enum Constants {
        static let cornerRadius: CGFloat = 16
        static let placeHolderImage: UIImage = UIImage(named: "moviePlaceholder", in: .module, compatibleWith: nil)!
    }
}

public class CoverPosterCardCell: UICollectionViewCell {
    public var presenter: CoverPosterCardCellPresenterInterface! {
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
    
    private lazy var informationContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        return label
    }()
}

// MARK: - CoverPosterCardCellViewInterface
extension CoverPosterCardCell: CoverPosterCardCellViewInterface {
    public func prepareUI() {
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
        
        addSubview(informationContainerStackView)
        informationContainerStackView.set(
            .leadingOf(self, 8),
            .top(coverImageView.bottom, 8),
            .trailingOf(self, 8),
            .bottomOf(self, 8)
        )
        
        informationContainerStackView.addArrangedSubview(titleLabel)
        informationContainerStackView.addArrangedSubview(subtitleLabel)
    }
    
    public func setCoverImageView(path: String) {
        coverImageView.setImage(path: path)
    }
    
    public func setTitleLabel(text: String) {
        titleLabel.text = text
    }
    
    public func setSubtitleLabel(text: String) {
        subtitleLabel.text = text
    }
}
