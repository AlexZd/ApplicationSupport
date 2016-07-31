//
//  Timeline.swift
//  Pods
//
//  Created by Vlad Gorbenko on 7/28/16.
//
//

import Foundation
import ApplicationSupport

public class Timeline {
    private var versions: [RecordObject] = []
    
    public init() {}
    public init(values: RecordObject) {
        self.versions << values
    }
    
    //MARK: - Management
    
    public func enqueu(snapshot: RecordObject) {
        self.versions << snapshot
    }
    
    public func dequeue() -> RecordObject? {
        if self.versions.count > 1 {
            let last = self.versions.last
            self.versions = Array(self.versions.dropLast())
            return last
        }
        return nil
    }
    
    var isEmpty: Bool { return self.versions.isEmpty }
    
    func compare(values: RecordObject) -> RecordObject {
        if let last = self.versions.last {
            var keys = Array(Set(last.keys).union(Set(values.keys)))
            var diff: RecordObject = [:]
            for key in keys {
                let left = last[key] as? DatabaseRepresentable
                let right = values[key] as? DatabaseRepresentable
                if !(left == right) {
                    diff[key] = right
                }
            }
            return diff
        }
        return values
    }
    
    public func reset(values: RecordObject) {
        self.versions.removeAll()
        self.versions << values
    }
}

