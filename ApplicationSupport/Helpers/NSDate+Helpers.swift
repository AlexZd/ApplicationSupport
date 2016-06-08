//
//  NSDate+Helpers.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/8/16.
//
//

import Foundation

public func == (l: NSDate?, r: NSDate?) -> Bool {
    if let right = r {
        return l?.compare(right) == .OrderedSame
    }
    return false
}

public func < (l: NSDate, r: NSDate) -> Bool {
    return l.compare(r) == .OrderedAscending
}

public func > (l: NSDate, r: NSDate) -> Bool {
    return l.compare(r) == .OrderedDescending
}
