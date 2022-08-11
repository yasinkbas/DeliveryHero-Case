//
//  EmptyView.swift
//  CommonKit
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit
import UILab

public protocol EmptyViewInterface: AnyObject {
    func prepareUI()
    func prepareTextLabel(message: String, color: UIColor, fontSize: Double)
}

public class EmptyView: UIView {
    var presenter: EmptyViewPresenterInterface! {
           didSet {
               presenter.load()
           }
       }
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        return label
    }()
}

// MARK: - EmptyViewInterface
extension EmptyView: EmptyViewInterface {
    public func prepareUI() {
        addSubview(textLabel)
        textLabel.set(.center(self))
    }
    
    public func prepareTextLabel(message: String, color: UIColor, fontSize: Double) {
        textLabel.text = message
        textLabel.textColor = color
        textLabel.font = .boldSystemFont(ofSize: fontSize.cgFloat)
    }
}
