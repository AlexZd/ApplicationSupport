//
//  Hardware.swift
//  Pods
//
//  Created by Vlad Gorbenko on 7/28/16.
//
//

import Foundation

public let IS_IPAD : Bool = UIDevice.currentDevice().userInterfaceIdiom == .Pad
public let IS_IPAD_PRO_BIG : Bool = (IS_IPAD && max(UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width) == 1366.0)

public let IS_IPHONE : Bool = UIDevice.currentDevice().userInterfaceIdiom == .Phone
public let IS_IPHONE_4 : Bool = (IS_IPHONE && UIScreen.mainScreen().bounds.size.height == 480.0)
public let IS_IPHONE_5 : Bool = (IS_IPHONE && UIScreen.mainScreen().bounds.size.height == 568.0)
public let IS_IPHONE_6 : Bool = (IS_IPHONE && UIScreen.mainScreen().bounds.size.height == 667.0)
public let IS_IPHONE_6_PLUS : Bool = (IS_IPHONE && UIScreen.mainScreen().bounds.size.height == 736.0)

public let IS_IPOD : Bool = UIDevice.currentDevice().model.rangeOfString("iPod") != nil

public let IS_RETINA : Bool = UIScreen.mainScreen().scale == 2