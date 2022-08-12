//
//  LoadingView.swift
//  CoreViewsKit
//
//  Created by Yasin Akbas on 12.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit
import UILab
import CommonKit

public protocol LoadingViewInterface: AnyObject {
    func prepareUI()
}

private extension LoadingView {
    enum Constant {
        static let backgroundColor: UIColor = Colors.background
        static let cornerRadius: CGFloat = 16
    }
}

public class LoadingView: UIView {
    var presenter: LoadingPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .large)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .gray)
        }
        activityIndicator.color = .yellow
        return activityIndicator
    }()
}

// MARK: - LoadingViewInterface
extension LoadingView: LoadingViewInterface {
    public func prepareUI() {
        backgroundColor = Constant.backgroundColor
        layer.cornerRadius = Constant.cornerRadius
        
        addSubview(activityIndicator)
        activityIndicator.set(.center(self))
        activityIndicator.startAnimating()
    }
}

