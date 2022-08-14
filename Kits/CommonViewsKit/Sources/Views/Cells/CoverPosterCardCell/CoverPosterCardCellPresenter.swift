//
//  CoverPosterCardCellPresenter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation

public protocol CoverPosterCardShowableModel {
    var coverPosterTitle: String { get }
    var coverPosterSubtitle: String? { get }
    var coverPosterImagePath: String { get }
}


public protocol CoverPosterCardCellPresenterInterface: AnyObject {
    func load()
}

public struct CoverPosterCardCellPresenterArguments {
    let title: String
    let secondaryTitle: String?
    let imageUrl: String
    
    public init(title: String, secondaryTitle: String?, imageUrl: String) {
        self.title = title
        self.secondaryTitle = secondaryTitle
        self.imageUrl = imageUrl
    }
}

public class CoverPosterCardCellPresenter {
    private weak var view: CoverPosterCardCellViewInterface?
    private let arguments: CoverPosterCardCellPresenterArguments

    public init(view: CoverPosterCardCellViewInterface, arguments: CoverPosterCardCellPresenterArguments) {
        self.view = view
        self.arguments = arguments
    }
    
    public convenience init(view: CoverPosterCardCellViewInterface, model: CoverPosterCardShowableModel) {
        self.init(view: view, arguments: .init(title: model.coverPosterTitle,
                                               secondaryTitle: model.coverPosterSubtitle,
                                               imageUrl: model.coverPosterImagePath))
    }
}

// MARK: - CoverPosterCardCellPresenterInterface
extension CoverPosterCardCellPresenter: CoverPosterCardCellPresenterInterface {
    public func load() {
        view?.prepareUI()
        view?.setCoverImageView(path: arguments.imageUrl)
        view?.setTitleLabel(text: arguments.title)
        view?.setSubtitleLabel(text: arguments.secondaryTitle ?? "")
    }
}
