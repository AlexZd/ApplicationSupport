//
//  Record.swift
//  Pods
//
//  Created by Alex Zdorovets on 7/26/16.
//
//

import Foundation
import ObjectMapper

public typealias RecordObject = [String: Any]
public typealias RecordsArray = [RecordObject]

public protocol Record: MetaRecord, Initiable, Mappable {
    var timeline: Timeline { get set }
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

public extension Record {
    public init?(_ map: Map) {
        self.init()
    }
}