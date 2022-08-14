//
//  PersonModuleInterface.swift
//  DependencyManagerKit
//
//  Created by Yasin Akbas on 15.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit

public protocol PersonModuleInterface: AnyObject {
    func personDetailViewController(for id: Int) -> UIViewController
}
