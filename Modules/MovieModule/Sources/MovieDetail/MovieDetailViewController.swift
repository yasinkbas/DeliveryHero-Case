//
//  MovieDetailViewController.swift
//  MovieModule
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit
import CommonViewsKit
import CommonKit

protocol MovieDetailViewInterface: EmptyViewShowable {
    func prepareUI()
}

class MovieDetailViewController: UIViewController {
    var presenter: MovieDetailPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - MovieDetailViewInterface
extension MovieDetailViewController: MovieDetailViewInterface {
    var emptyViewArguments: EmptyViewPresenterArguments {
        .init(message: presenter.emptyViewMessage,
              titleColor: .white,
              titleFontSize: 18)
    }
    
    func prepareUI() { 
        view.backgroundColor = Colors.background
    }
}
