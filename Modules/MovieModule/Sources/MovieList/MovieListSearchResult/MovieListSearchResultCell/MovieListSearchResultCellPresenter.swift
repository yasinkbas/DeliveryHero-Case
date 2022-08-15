//
//  MovieListSearchResultCellPresenter.swift
//  MovieModule
//
//  Created by Yasin Akbas on 13.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import CommonViewsKit

protocol MovieListSearchResultCellPresenterInterface: AnyObject {
    var sizeOfCell: (width: Double, height: Double) { get }
    var minimumInteritemSpacingForSectionAt: Double { get }
    var numberOfItemsInSection: Int { get }
    
    func load()
    func coverPosterCardCellModel(for indexPath: IndexPath) -> CoverPosterCardShowableModel
    func didSelectItemAt(indexPath: IndexPath)
}

protocol MovieListSearchResultCellPresenterDelegate: AnyObject {
    func navigateToPersonDetail(with id: Int)
    func navigateToMovieDetail(with id: Int)
}

struct MovieListSearchResultCellPresenterArguments {
    let widget: MovieListSearchResultWidgetItem
    weak var delegate: MovieListSearchResultCellPresenterDelegate?
}

private extension MovieListSearchResultCellPresenter {
    enum Constants {
        enum WidgetInnerCell {
            static let defaultWidth: Double = 140
            static let defaultPadding: Double = 40
            static let peopleWidth: Double = 100
            static let peoplePadding: Double = 50
        }
        
        static let minimumInteritemSpacingForSectionAt: Double = 10
    }
}

final class MovieListSearchResultCellPresenter {
    private weak var view: MovieListSearchResultCellViewInterface?
    private let arguments: MovieListSearchResultCellPresenterArguments
    
    init(
        view: MovieListSearchResultCellViewInterface,
        arguments: MovieListSearchResultCellPresenterArguments
    ) {
        self.view = view
        self.arguments = arguments
    }
    
    private func size(for widget: MovieListSearchResultWidgetItem) -> (width: Double, height: Double) {
        switch widget.widgetType {
        case .people:
            let width: Double = Constants.WidgetInnerCell.peopleWidth
            let height: Double = widget.height - Constants.WidgetInnerCell.peoplePadding
            return (width, height)
        default: // movie, genre
            let width: Double = Constants.WidgetInnerCell.defaultWidth
            let height: Double = widget.height - Constants.WidgetInnerCell.defaultPadding
            return (width, height)
        }
    }
}

// MARK: - MovieListSearchResultCellPresenterInterface
extension MovieListSearchResultCellPresenter: MovieListSearchResultCellPresenterInterface {
    var sizeOfCell: (width: Double, height: Double) {
        size(for: arguments.widget)
    }
    
    var minimumInteritemSpacingForSectionAt: Double {
        Constants.minimumInteritemSpacingForSectionAt
    }
    
    var numberOfItemsInSection: Int {
        arguments.widget.result.count
    }
    
    func load() {
        view?.prepareUI()
        view?.setTitleLabel(text: arguments.widget.title)
    }
    
    func coverPosterCardCellModel(for indexPath: IndexPath) -> CoverPosterCardShowableModel {
        arguments.widget.result[indexPath.item]
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        if arguments.widget.widgetType == .people,
            let personId = arguments.widget.result[indexPath.item].coverPosterId {
            arguments.delegate?.navigateToPersonDetail(with: personId)
        } else if let movieId = arguments.widget.result[indexPath.item].coverPosterId {
            arguments.delegate?.navigateToMovieDetail(with: movieId)
        }
    }
}
