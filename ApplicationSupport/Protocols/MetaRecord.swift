//
//  MetaRecord.swift
//  Pods
//
//  Created by Alex Zdorovets on 7/26/16.
//
//

import Foundation

public protocol MetaRecord {}

public extension MetaRecord {
    public final static var modelName: String {
        let reflect = _reflect(self)
        var className = "\(reflect.summary)"
        if let typeRange = className.rangeOfString(".Type") {
            className.replaceRange(typeRange, with: "")
        }
        return className.componentsSeparatedByString(".").dropFirst().joinWithSeparator(".")
    }
}