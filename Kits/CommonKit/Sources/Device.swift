//
//  Device.swift
//  CommonKit
//
//  Created by Yasin Akbas on 11.08.2022.
//  Copyright © 2022 com.yasinkbas. All rights reserved.
//

import UIKit

public enum Device {
    public static let screenWidth       = Double(UIScreen.main.bounds.size.width)
    public static let screenHeight      = Double(UIScreen.main.bounds.size.height)
    public static let screenMaxLength   = Double( max(screenWidth, screenHeight) )
    public static let screenMinLength   = Double( min(screenWidth, screenHeight) )
    
    public static let isIphoneXOrBigger = screenMaxLength >= 812
}
