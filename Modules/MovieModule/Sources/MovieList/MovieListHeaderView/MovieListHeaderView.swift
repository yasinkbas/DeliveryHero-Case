//
//  MovieListHeaderViewController.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit
import CommonKit

protocol MovieListHeaderViewInterface: AnyObject {
    func prepareUI()
    func showSearchTextField()
    func hideSearchTextField()
    func setTextField(text: String)
}

private extension MovieListHeaderView {
    enum Constants {
        enum TitleLabel {
            static let text: String = "Delivery Hero"
            static let orangedText: String = "Hero"
            static let primaryTextColor: UIColor = .white
            static let secondaryTextColor: UIColor = .orange
            static let font: UIFont = .boldSystemFont(ofSize: 22)
            static let bottomPadding: CGFloat = 16
        }
        
        enum SearchContainerView {
            static let backgroundColor: UIColor = #colorLiteral(red: 0.1483550668, green: 0.1483550668, blue: 0.1483550668, alpha: 1)
            static let cornerRadius: CGFloat = 16
        }
        
        enum Images {
            static let searchIcon: UIImage? = UIImage(named: "searchIcon",
                                                      in: .module,
                                                      compatibleWith: nil)
            static let closeIcon: UIImage? = UIImage(named: "closeIcon",
                                                      in: .module,
                                                      compatibleWith: nil)
            static let doneIcon: UIImage? = UIImage(named: "doneIcon",
                                                    in: .module,
                                                    compatibleWith: nil)
        }
        
        static let animationDuration: CGFloat = 0.4
    }
}

final class MovieListHeaderView: UIView {
    var presenter: MovieListHeaderPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.TitleLabel.primaryTextColor
        label.font = Constants.TitleLabel.font
        label.attributedText = Constants.TitleLabel.text.setColor(
            Constants.TitleLabel.secondaryTextColor,
            ofSubstring: Constants.TitleLabel.orangedText
        )
        return label
    }()
    
    private lazy var searchContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.SearchContainerView.backgroundColor
        view.layer.cornerRadius = Constants.SearchContainerView.cornerRadius
        return view
    }()
    
    private lazy var searchContainerViewLeftIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.searchIcon?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var searchContainerViewLeftSpacerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.tintColor = .yellow
        textField.textColor = .white
        textField.alpha = 0
        return textField
    }()
    
    private lazy var doneContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.alpha = 0
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private lazy var doneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.doneIcon
        return imageView
    }()
    
    @objc
    private func doneIconTapped() {
        presenter.doneIconTapped()
    }
    
    @objc
    private func searchContainerViewTapped() {
        presenter.searchContainerViewTapped()
    }
    
    @objc
    private func searchTextFieldDidChange(_ textField: UITextField) {
        presenter.searchTextFieldDidChange(textField.text)
    }
}

// MARK: - MovieListHeaderViewInterface
extension MovieListHeaderView: MovieListHeaderViewInterface {
    func prepareUI() {
        backgroundColor = Colors.navigationBackground
        
        addSubview(titleLabel)
        titleLabel.set(
            .leadingOf(self, 16),
            .bottomOf(self, Constants.TitleLabel.bottomPadding)
        )
        
        addSubview(searchContainerView)
        searchContainerView.set(
            .rightOf(self, 16),
            .centerYOf(titleLabel),
            .width(32),
            .height(32)
        )
        
        searchContainerView.addSubview(searchContainerViewLeftIcon)
        searchContainerViewLeftIcon.set(
            .centerYOf(searchContainerView),
            .leadingOf(searchContainerView, 8),
            .width(16),
            .height(16)
        )
        
        searchContainerView.addSubview(searchContainerViewLeftSpacerView)
        searchContainerViewLeftSpacerView.set(
            .leading(searchContainerViewLeftIcon.trailing),
            .width(0),
            .height(1)
        )
        
        doneContainerView.addSubview(doneImageView)
        doneImageView.set(
            .center(doneContainerView),
            .width(10),
            .height(17)
        )
        
        searchContainerView.addSubview(doneContainerView)
        doneContainerView.set(
            .trailingOf(searchContainerView),
            .heightOf(searchContainerView),
            .width(0)
        )
        
        searchContainerView.addSubview(searchTextField)
        searchTextField.set(
            .leading(searchContainerViewLeftSpacerView.trailing),
            .centerYOf(searchContainerView),
            .trailing(doneContainerView.leading, 4)
        )
        
        doneContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doneIconTapped)))
        searchContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchContainerViewTapped)))
        searchTextField.addTarget(self, action: #selector(searchTextFieldDidChange), for: .editingChanged)
    }
    
    func showSearchTextField() {
        searchContainerView.get(.width).first?.constant = CGFloat(Device.screenWidth / 2 - 10)
        searchContainerViewLeftSpacerView.get(.width).first?.constant = 4
        doneContainerView.get(.width).first?.constant = 30
        UIView.animate(withDuration: Constants.animationDuration) {
            self.layoutIfNeeded()
            self.searchTextField.alpha = 1
            self.doneContainerView.alpha = 1
            self.searchContainerViewLeftIcon.image = Constants.Images.closeIcon?.withRenderingMode(.alwaysTemplate)
            self.searchContainerViewLeftIcon.tintColor = .orange
        }
    }
    
    func hideSearchTextField() {
        searchContainerView.get(.width).first?.constant = CGFloat(32)
        searchContainerViewLeftSpacerView.get(.width).first?.constant = 0
        doneContainerView.get(.width).first?.constant = 0
        UIView.animate(withDuration: Constants.animationDuration) {
            self.layoutIfNeeded()
            self.searchTextField.alpha = 0
            self.doneContainerView.alpha = 0
            self.searchContainerViewLeftIcon.image = Constants.Images.searchIcon?.withRenderingMode(.alwaysTemplate)
            self.searchContainerViewLeftIcon.tintColor = .white
        }
    }
    
    func setTextField(text: String) {
        searchTextField.text = text
    }
}
