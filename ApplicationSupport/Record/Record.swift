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
    
    mutating func update(with attributes: RecordObject)
}

public extension Record {
    // Returns an instance of Record object
    public init?(map: Map) {
        self.init()
    }
    
    init(with attributes: RecordObject) {
        self.init()
        let map = Map(mappingType: .fromJSON, JSON: attributes, toObject: true, context: nil)
        self.mapping(map: map)
        self.timeline.enqueue(attributes)
    }
    
    mutating func update(with attributes: RecordObject) {
        let map = Map(mappingType: .fromJSON, JSON: attributes, toObject: true, context: nil)
        self.mapping(map: map)
        self.timeline.enqueue(attributes)
    }
}
