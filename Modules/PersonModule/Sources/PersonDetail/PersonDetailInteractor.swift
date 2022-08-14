//
//  PersonDetailInteractor.swift
//  PersonModule
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import Foundation

protocol PersonDetailInteractorInterface: AnyObject {

}

protocol PersonDetailInteractorOutput: AnyObject {
    
}

final class PersonDetailInteractor {
    weak var output: PersonDetailInteractorOutput?
}

// MARK: - PersonDetailInteractorInterface
extension PersonDetailInteractor: PersonDetailInteractorInterface { 

}
