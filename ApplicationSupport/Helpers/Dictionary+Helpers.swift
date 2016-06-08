//
//  Dictionary+Helpers.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/8/16.
//
//

import Foundation

public func += <KeyType, ValueType> (inout left: Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}

public func + <K,V>(left: Dictionary<K,V>, right: Dictionary<K,V>?) -> Dictionary<K,V> {
    var map = Dictionary<K,V>()
    for (k, v) in left {
        map[k] = v
    }
    if let dictionary = right {
        for (k, v) in dictionary {
            map[k] = v
        }
    }
    
    return map
}

public func * <K,V>(left: Dictionary<K,V>, right: Dictionary<K,V>?) -> Dictionary<K,V> {
    var map = Dictionary<K,V>()
    if let dictionary = right {
        for (k, v) in dictionary {
            map[k] = v
        }
    }
    for (k, v) in left {
        map[k] = v
    }
    return map
}

extension Dictionary {
    
    public mutating func merge<K, V>(dict: [K: V]){
        for (k, v) in dict {
            self.updateValue(v as! Value, forKey: k as! Key)
        }
    }
    
    public mutating func removeAll(except all: [AnyObject]) {
        for key in Array(self.keys) {
            if all.contains(key) == false {
                self.removeValueForKey(key)
            }
        }
    }
    
    public mutating func removeAll(only all : [AnyObject]) {
        for key in Array(self.keys) {
            if all.contains(key) {
                self.removeValueForKey(key)
            }
        }
    }
    
    public func slice(keys: [Key]) -> [Key:Value] {
        return self.filter({ keys.contains($0.0) }).reduce([:], combine: { $0 + [$1.0 : $1.1] })
    }
    
    public func except(keys: [Key]) -> [Key: Value] {
        return self.filter({ keys.contains($0.0) == false }).reduce([:], combine: { $0 + [$1.0 : $1.1] })
    }
    
}
