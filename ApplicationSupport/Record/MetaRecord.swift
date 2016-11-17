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
    // Use debugPrint to receive nested classes names.
    public final static var modelName: String {
        var className = ""
        debugPrint(self, separator: "", terminator: "", to: &className)
        return className.components(separatedBy: ".").dropFirst().joined(".")
    }
}
