//
//  ClassFromString.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/19/16.
//
//

import Foundation

public func ClassFromString(_ className: String) -> AnyClass {
    var cls: AnyClass? = NSClassFromString(className)
    if let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as? String, cls == nil {
        let name = appName + "." + className
        cls = NSClassFromString(name)
        if cls == nil {
            fatalError("Unable to find `\(name)`")
        }
    }
    return cls!
}
