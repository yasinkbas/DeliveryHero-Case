//
//  AlertShowable.swift
//  CoreViewsKit
//
//  Created by Yasin Akbas on 13.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit

public protocol AlertShowable: AnyObject {
    func showAlert(message: String)
}

public extension AlertShowable where Self: UIViewController {
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: "Ok", style: .default))
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
