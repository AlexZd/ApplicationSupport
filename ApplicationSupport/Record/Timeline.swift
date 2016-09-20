//
//  Timeline.swift
//  Pods
//
//  Created by Vlad Gorbenko on 7/28/16.
//
//

import Foundation
import ApplicationSupport

open class Timeline {
    open var versions: [RecordObject] = []
    
    public init() {}
    public init(values: RecordObject) {
        self.versions << values
    }
    
    //MARK: - Management
    
    open func enqueue(_ snapshot: RecordObject) {
        self.versions << snapshot
    }
    
    open func dequeue() -> RecordObject? {
        if self.versions.count > 1 {
            let last = self.versions.last
            self.versions = Array(self.versions.dropLast())
            return last
        }
        return nil
    }
    
    var isEmpty: Bool { return self.versions.isEmpty }
    
    func compare(_ values: RecordObject) -> RecordObject {
        if let last = self.versions.last {
            let keys = Array(Set(last.keys).union(Set(values.keys)))
            var diff: RecordObject = [:]
            for key in keys {
                let left = last[key] as? DatabaseRepresentable
                let right = values[key] as? DatabaseRepresentable
                if let r = right {
                    diff[key] = right
                } else if let l = left {
                    diff[key] = l
                } else {
                    let leftArr = last[key] as? [[String: Any]]
                    let rightArr = values[key] as? [[String: Any]]
                    if let r = rightArr {
                        diff[key] = r
                    } else if let l = leftArr {
                        diff[key] = l
                    } else {
                        let leftArr = last[key] as? [String: Any]
                        let rightArr = values[key] as? [String: Any]
                        if let r = rightArr {
                            diff[key] = r
                        } else if let l = leftArr {
                            diff[key] = l
                        }
                    }
                }
            }
            return diff
        }
        return values
    }
    
    open func reset(_ values: RecordObject) {
        self.versions.removeAll()
        self.versions << values
    }
}

