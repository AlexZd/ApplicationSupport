//
//  Record+Attributes.swift
//  Pods
//
//  Created by Vlad Gorbenko on 7/28/16.
//
//

import Foundation
import ObjectMapper

extension Record {
 
    public var attributes: RecordObject {
        get { return self.toJSON() }
        set { self.mapping(Map(mappingType: .fromJSON, JSONDictionary: newValue, toObject: true, context: nil)) }
    }
    
    public var defaultValues: [String: Any] {
        let attributes = self.attributes
        return attributes
        
    }
}

extension Record {
    public var dirty: RecordObject { return self.timeline.compare(self.attributes) }
}
