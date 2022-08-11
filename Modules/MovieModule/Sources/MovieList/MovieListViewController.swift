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
}

extension MovieListViewController {
    enum Constants {
        enum EmptyView {
            static let message: String = "No results found"
            static let titleColor: UIColor = .white
            static let titleFontSize: CGFloat = 26
        }
    }
}

class MovieListViewController: UIViewController {
    var presenter: MovieListPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - MovieListViewInterface
extension MovieListViewController: MovieListViewInterface {
    var emptyViewArguments: EmptyViewPresenterArguments {
        .init(
            message: Constants.EmptyView.message,
            titleColor: Constants.EmptyView.titleColor,
            titleFontSize: Constants.EmptyView.titleFontSize
        )
    }
    
    func prepareUI() { 
        view.backgroundColor = Colors.background
    }
}
