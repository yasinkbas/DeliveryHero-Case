//
//  PersonDetailViewController.swift
//  PersonModule
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit
import CommonViewsKit
import CommonKit

protocol PersonDetailViewInterface: AnyObject, EmptyViewShowable {
    func prepareUI()
}

class PersonDetailViewController: UIViewController {
    var presenter: PersonDetailPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - PersonDetailViewInterface
extension PersonDetailViewController: PersonDetailViewInterface {
    var emptyViewArguments: EmptyViewPresenterArguments {
        .init(message: presenter.emptyViewMessage,
              titleColor: .white,
              titleFontSize: 18)
    }
    
    func prepareUI() { 
        view.backgroundColor = Colors.background
    }
}
