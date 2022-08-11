//
//  MovieListInteractor.swift
//  MovieModule
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation
import NetworkManagerKit

protocol MovieListInteractorInterface: AnyObject {

}

protocol MovieListInteractorOutput: AnyObject {
    
}

final class MovieListInteractor {
    weak var output: MovieListInteractorOutput?
}

// MARK: - MovieListInteractorInterface
extension MovieListInteractor: MovieListInteractorInterface { 

}
