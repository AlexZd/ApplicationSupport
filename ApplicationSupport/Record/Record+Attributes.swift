//
//  Record+Attributes.swift
//  Pods
//
//  Created by Vlad Gorbenko on 7/28/16.
//
//

import Foundation

extension Record {
 
    public var attributes: RecordObject {
        get { return getAttributes() }
        set { self.setAttributes(newValue) }
    }
    
    public var defaultValues: [String: Any] {
        let attributes = self.attributes
        return attributes
        
    }
}

extension Record {
    public var dirty: RecordObject { return self.timeline.compare(self.attributes) }
}