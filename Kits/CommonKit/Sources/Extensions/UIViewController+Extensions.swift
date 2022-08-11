//
//  UIViewController+Extensions.swift
//  CommonKit
//
//  Created by Yasin Akbas on 12.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit

public extension UIViewController {
    func embed(_ viewController: UIViewController, in view: UIView){
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        addChild(viewController)
        viewController.didMove(toParent: self)
    }
}
