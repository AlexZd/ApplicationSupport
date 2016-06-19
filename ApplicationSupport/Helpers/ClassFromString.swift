//
//  ClassFromString.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/19/16.
//
//

import Foundation

public func ClassFromString(className: String) -> AnyClass {
    var cls : AnyClass? = NSClassFromString(className)
    if let appName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleExecutable") as? String where cls == nil {
        let name = appName + className
        cls = NSClassFromString(name)
        if cls == nil {
            fatalError("Unable to find `\(name)`")
        }
    }
    return cls!
}