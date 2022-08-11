//
//  MovieListViewController.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit

protocol MovieListViewInterface: AnyObject {
    func prepareUI()
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
    func prepareUI() { 
        view.backgroundColor = .purple
    }
}
