//
//  EmptyViewShowable.swift
//  CommonKit
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit
import UILab

public protocol EmptyViewShowable: AnyObject {
    var emptyViewArguments: EmptyViewPresenterArguments { get }
    
    func showEmptyView()
    func hideEmptyView()
}

public extension EmptyViewShowable where Self: UIViewController {
    func showEmptyView() {
        let emptyView = EmptyView()
        let presenter = EmptyViewPresenter(view: emptyView, arguments: emptyViewArguments)
        emptyView.presenter = presenter
        view.addSubview(emptyView)
        emptyView.set(.leadingOf(view), .topOf(view), .trailingOf(view), .bottomOf(view))
    }
    
    func hideEmptyView() {
        for view in view.subviews where view is EmptyView {
            view.removeFromSuperview()
        }
    }
}
