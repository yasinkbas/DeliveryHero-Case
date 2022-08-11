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
    var emptyViewContainerView: UIView { get }
    var emptyViewPaddings: UIEdgeInsets { get }
    
    func showEmptyView()
    func hideEmptyView()
}

public extension EmptyViewShowable where Self: UIViewController {
    var emptyViewContainerView: UIView {
        view
    }
    
    var emptyViewPaddings: UIEdgeInsets {
        UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
    }
    
    func showEmptyView() {
        let emptyView = EmptyView()
        let presenter = EmptyViewPresenter(view: emptyView, arguments: emptyViewArguments)
        emptyView.presenter = presenter
        emptyViewContainerView.addSubview(emptyView)
        emptyView.set(
            .leadingOf(emptyViewContainerView, emptyViewPaddings.left),
            .topOf(emptyViewContainerView, emptyViewPaddings.top),
            .trailingOf(emptyViewContainerView, emptyViewPaddings.right),
            .bottomOf(emptyViewContainerView, emptyViewPaddings.bottom)
        )
    }
    
    func hideEmptyView() {
        for view in view.subviews where view is EmptyView {
            view.removeFromSuperview()
        }
    }
}
