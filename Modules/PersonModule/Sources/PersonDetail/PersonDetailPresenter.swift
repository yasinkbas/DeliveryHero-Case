//
//  PersonDetailPresenter.swift
//  PersonModule
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation

protocol PersonDetailPresenterInterface: AnyObject {
    var emptyViewMessage: String { get }
    
    func viewDidLoad()
}

struct PersonDetailPresenterArguments {
    let id: Int
}

final class PersonDetailPresenter {
    private weak var view: PersonDetailViewInterface?
    private let router: PersonDetailRouterInterface
    private let interactor: PersonDetailInteractorInterface
    private let arguments: PersonDetailPresenterArguments

    init(
        view: PersonDetailViewInterface,
        router: PersonDetailRouterInterface,
        interactor: PersonDetailInteractorInterface,
        arguments: PersonDetailPresenterArguments
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.arguments = arguments
    }
}

// MARK: - PersonDetailPresenterInterface
extension PersonDetailPresenter: PersonDetailPresenterInterface {
    var emptyViewMessage: String {
        "Test - ID(\(arguments.id)) Person Detail Page"
    }
    
    func viewDidLoad() {
        view?.prepareUI()
        view?.showEmptyView()
    }
}

// MARK: - PersonDetailInteractorOutput
extension PersonDetailPresenter: PersonDetailInteractorOutput { 
    
}
