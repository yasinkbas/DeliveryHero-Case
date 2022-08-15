//
//  PersonDetailRouter.swift
//  PersonModule
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit

protocol PersonDetailRouterInterface: AnyObject {
    
}

final class PersonDetailRouter {
    static func createModule(arguments: PersonDetailPresenterArguments) -> PersonDetailViewController {
        let view = PersonDetailViewController()
        let interactor = PersonDetailInteractor()
        let router = PersonDetailRouter()
        let presenter = PersonDetailPresenter(view: view, router: router, interactor: interactor, arguments: arguments)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

// MARK: - PersonDetailRouterInterface
extension PersonDetailRouter: PersonDetailRouterInterface { 
    
}

