//
//  LoadingShowable.swift
//  CoreViewsKit
//
//  Created by Yasin Akbas on 12.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit

public protocol LoadingShowable: AnyObject {
    func showLoading()
    func hideLoading()
}

public extension LoadingShowable where Self: UIViewController {
    func showLoading() {
        let loadingView = LoadingView()
        let presenter = LoadingPresenter(view: loadingView)
        loadingView.presenter = presenter

        view.addSubview(loadingView)
        loadingView.set(.center(view), .width(100), .height(100))
    }
    
    func hideLoading() {
        for view in view.subviews where view is LoadingView {
            UIView.animate(withDuration: 0.3) {
                view.alpha = 0
            } completion: { completion in
                view.removeFromSuperview()
            }
        }
    }
}
