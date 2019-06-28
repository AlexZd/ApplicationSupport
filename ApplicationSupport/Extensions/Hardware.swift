//
//  Hardware.swift
//  Pods
//
//  Created by Vlad Gorbenko on 7/28/16.
//
//

import Foundation

public let IS_IPAD : Bool = UIDevice.current.userInterfaceIdiom == .pad
public let IS_IPAD_PRO_BIG : Bool = (IS_IPAD && max(UIScreen.main.bounds.size.height, UIScreen.main.bounds.size.width) == 1366.0)

public let IS_IPHONE : Bool = UIDevice.current.userInterfaceIdiom == .phone
public let IS_IPHONE_4 : Bool = (IS_IPHONE && UIScreen.main.bounds.size.height == 480.0)
public let IS_IPHONE_5 : Bool = (IS_IPHONE && UIScreen.main.bounds.size.height == 568.0)
public let IS_IPHONE_6 : Bool = (IS_IPHONE && UIScreen.main.bounds.size.height == 667.0)
public let IS_IPHONE_6_PLUS : Bool = (IS_IPHONE && UIScreen.main.bounds.size.height == 736.0)
public let IS_IPHONE_X : Bool = (IS_IPHONE && UIScreen.main.bounds.size.height == 812.0)
public let IS_IPHONE_XS_MAX: Bool = (IS_IPHONE && UIScreen.main.bounds.size.height == 896.0)
public var HAS_HOME_BUTTON: Bool {
    if #available(iOS 11.0, *), let keyWindow = UIApplication.shared.keyWindow, keyWindow.safeAreaInsets.bottom > 0 {
        return false
    }
    return true
}

public let IS_IPOD : Bool = UIDevice.current.model.range(of: "iPod") != nil

public let IS_RETINA : Bool = UIScreen.main.scale == 2
