//
//  MovieDetailInteractor.swift
//  MovieModule
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation

protocol MovieDetailInteractorInterface: AnyObject {

}

protocol MovieDetailInteractorOutput: AnyObject {
    
}

final class MovieDetailInteractor {
    weak var output: MovieDetailInteractorOutput?
}

// MARK: - MovieDetailInteractorInterface
extension MovieDetailInteractor: MovieDetailInteractorInterface { 

}
