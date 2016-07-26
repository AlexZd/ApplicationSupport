//
//  Record.swift
//  Pods
//
//  Created by Alex Zdorovets on 7/26/16.
//
//

import Foundation

public protocol Record: MetaRecord, Initiable {
    func setAttributes(attributes: JSONObject)
    func getAttributes() -> JSONObject
    
    func setAttributes(action: String, attributes: JSONObject)
    func getAttributes(action: String) -> JSONObject
}

public extension Record {
    func setAttributes(attributes: JSONObject) {}
    func getAttributes() -> JSONObject { return JSONObject() }
    
    func setAttributes(action: String, attributes: JSONObject) {}
    func getAttributes(action: String) -> JSONObject { return JSONObject() }
}

public extension Record {
    init(attributes: JSONObject, action: String) {
        self.init()
        self.setAttributes(action, attributes: attributes)
    }
}

public extension Record {
    public static var resourceName: String {
        let components = self.modelName.componentsSeparatedByString(".").map({ $0.lowercaseString })
        return components.dropLast().joinWithSeparator("_") + "_" + components.last!.lowercaseString.pluralized
    }
}