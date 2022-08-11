//
//  EmptyView.swift
//  CommonKit
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit
import UILab
import CommonKit

public protocol EmptyViewInterface: AnyObject {
    func prepareUI()
    func prepareTextLabel(message: String, color: UIColor, fontSize: Double)
}

private extension EmptyView {
    enum Constants {
        enum ContainerView {
            static let backgroundColor: UIColor = UIColor.white.withAlphaComponent(0.2)
            static let cornerRadius: CGFloat = 16
        }
        
        enum TextLabel {
            static let padding: CGFloat = 15
        }
    }
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
    
    private lazy var textLabelContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.ContainerView.backgroundColor
        view.layer.cornerRadius = Constants.ContainerView.cornerRadius
        return view
    }()
}

// MARK: - EmptyViewInterface
extension EmptyView: EmptyViewInterface {
    public func prepareUI() {
        addSubview(textLabelContainerView)
        textLabelContainerView.set(.center(self))
        
        addSubview(textLabel)
        textLabel.set(
            .leadingOf(textLabelContainerView, Constants.TextLabel.padding),
            .topOf(textLabelContainerView, Constants.TextLabel.padding),
            .bottomOf(textLabelContainerView, Constants.TextLabel.padding),
            .rightOf(textLabelContainerView, Constants.TextLabel.padding)
        )
    }
    
    public func prepareTextLabel(message: String, color: UIColor, fontSize: Double) {
        textLabel.text = message
        textLabel.textColor = color
        textLabel.font = .boldSystemFont(ofSize: fontSize.cgFloat)
    }
}
