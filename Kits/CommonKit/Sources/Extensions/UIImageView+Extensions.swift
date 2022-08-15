//
//  UIImageView+Extensions.swift
//  CommonKit
//
//  Created by Yasin Akbas on 12.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit
import SDWebImage

public extension UIImageView {
    func setImage(path: String, placeholder: UIImage? = nil) {
        guard let url = URL(string: path) else { return }
        sd_setImage(with: url, placeholderImage: placeholder)
    }
}
