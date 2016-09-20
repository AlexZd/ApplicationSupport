//
//  MetaRecord.swift
//  Pods
//
//  Created by Alex Zdorovets on 7/26/16.
//
//

import Foundation

public protocol Identifiable {
    var id : Any! { get set }
}

public protocol Initiable {
    init()
}

public protocol MetaRecord {}

public extension MetaRecord {
    public final static var modelName: String {
        let reflect = Mirror(reflecting: self)
        var className = "\(reflect.description)"
        if let typeRange = className.range(of: ".Type") {
            className.replaceSubrange(typeRange, with: "")
        }
        return className.components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
}
