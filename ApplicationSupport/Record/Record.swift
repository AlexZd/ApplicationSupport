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
    
//    init?(with map: Map)
//    init(with attributes: RecordObject)
    mutating func update(with attributes: RecordObject)
}

public extension Record {
    // Returns in User.Session returns user/sessions
    public static var resourcesName: String {
        return self.resourceName.pluralized
    }
    
    public static var resourceName: String {
        let components = self.modelName.components(separatedBy: ".").map({ $0.lowercased() })
        return components.dropLast().joined(separator: "_") + (components.count > 1 ? "_" + components.last!.lowercased().pluralized : components.last!.lowercased())
    }

    public static var className: String {
        let component = self.modelName.components(separatedBy: ".").map({ $0.lowercased() }).last
        return component ?? ""
    }
}

public extension Record {
    // Returns an instance of Record object
    init?(with map: Map) {
        self.init()
    }
    
    init(with attributes: RecordObject) {
        self.init()
        let map = Map(mappingType: .fromJSON, JSONDictionary: attributes, toObject: true, context: nil)
        self.mapping(map)
        self.timeline.enqueue(attributes)
    }
    
    mutating func update(with attributes: RecordObject) {
        let map = Map(mappingType: .fromJSON, JSONDictionary: attributes, toObject: true, context: nil)
        self.mapping(map)
        self.timeline.enqueue(attributes)
    }
}
