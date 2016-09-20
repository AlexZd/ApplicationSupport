//
//  NSDate+Helpers.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/8/16.
//
//

import Foundation

public func == (l: Foundation.Date?, r: Foundation.Date?) -> Bool {
    if let right = r {
        return l?.compare(right) == .orderedSame
    }
    return false
}

public func < (l: Foundation.Date, r: Foundation.Date) -> Bool {
    return l.compare(r) == .orderedAscending
}

public func > (l: Foundation.Date, r: Foundation.Date) -> Bool {
    return l.compare(r) == .orderedDescending
}
