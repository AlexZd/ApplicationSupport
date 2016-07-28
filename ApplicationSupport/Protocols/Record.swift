//
//  Record.swift
//  Pods
//
//  Created by Alex Zdorovets on 7/26/16.
//
//

import Foundation

public typealias RecordObject = [String:AnyObject]
public typealias RecordsArray = [RecordObject]

public protocol Record: MetaRecord, Initiable {
    func setAttributes(attributes: RecordObject)
    func getAttributes() -> RecordObject
    
    func setAttributes(action: String, attributes: RecordObject)
    func getAttributes(action: String) -> RecordObject
}

public extension Record {
    public func setAttributes(attributes: RecordObject) {}
    public func getAttributes() -> RecordObject { return RecordObject() }
    
    public func setAttributes(action: String, attributes: RecordObject) {}
    public func getAttributes(action: String) -> RecordObject { return RecordObject() }
}

public extension Record {
    public init(attributes: RecordObject, action: String) {
        self.init()
        self.setAttributes(action, attributes: attributes)
    }
}

public extension Record {
    // Returns in User.Session returns user/sessions
    public static var resourcesName: String {
        return self.resourceName.pluralized
    }
    
    public static var resourceName: String {
        let components = self.modelName.componentsSeparatedByString(".").map({ $0.lowercaseString })
        return components.dropLast().joinWithSeparator("_") + (components.count > 1 ? "_" + components.last!.lowercaseString.pluralized : components.last!.lowercaseString)
    }
}