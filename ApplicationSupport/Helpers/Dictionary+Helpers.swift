//
//  Dictionary+Helpers.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/8/16.
//
//

import Foundation

public func += <K, V> (inout left: [K: V], right: [K: V]?) {
    if let right = right {
        for (k, v) in right {
            if let leftDictionary = left[k] as? [K: V], let rightDictionary = right[k] as? [K: V] {
                left[k] = (leftDictionary + rightDictionary) as? V
            } else if let leftArray = left[k] as? [V], let rightArray = right[k] as? [V] {
                left[k] = (leftArray + rightArray) as? V
            } else {
                left.updateValue(v, forKey: k)
            }
        }
    }
}

public func + <K,V>(left: [K: V]?, right: [K: V]?) -> [K: V] {
    var map = [K: V]()
    if let left = left {
        for (k, v) in left {
            map[k] = v
        }
    }
    if let right = right {
        for (k, v) in right {
            if let leftDictionary = left?[k] as? [K: V], let rightDictionary = right[k] as? [K: V] {
                map[k] = (leftDictionary + rightDictionary) as? V
            } else if let leftArray = left?[k] as? [V], let rightArray = right[k] as? [V] {
                map[k] = (leftArray + rightArray) as? V
            } else {
                map.updateValue(v, forKey: k)
            }
        }
    }
    return map
}

//public func + <K,V>(left: Dictionary<K,AnyObject>, right: Dictionary<K,V>?) -> Dictionary<K,AnyObject> {
//    var map = Dictionary<K,AnyObject>()
//    for (k, v) in left {
//        map[k] = v
//    }
//    if let dictionary = right {
//        for (k, v) in dictionary {
//            if let value = v as? AnyObject {
//                map[k] = value
//            }
//        }
//    }
//    return map
//}

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

// Rotate dictionary from [String: Any] to [String: AnyObject]
public extension Dictionary where Key: StringLiteralConvertible, Value: Any {
    var pure: [Key: AnyObject] {
        var pure: [Key: AnyObject] = [:]
        for (k, v) in self {
            if let value = v as? AnyObject {
                pure[k] = value
//            } else if let value = v as? RecordObject {
//                pure[k] = value.pure
//            } else if let value = v as? RecordsArray {
//                pure[k] = value.map({ $0.pure })
            }
        }
        return pure
    }
}

// Rotate dictionary from [String: AnyObject] to [String: Any]
public extension Dictionary where Key: StringLiteralConvertible, Value: AnyObject {
    var pure: [Key: Any] {
        var pure: [Key: Any] = [:]
        for (k, v) in self {
            pure[k] = v
        }
        return pure
    }
}
