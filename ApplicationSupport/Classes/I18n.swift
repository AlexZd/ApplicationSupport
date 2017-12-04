//
//  I18n.swift
//  Pods
//
//  Created by Alex Zdorovets on 5/18/16.
//
//

import Foundation

final public class I18n {
    public class func translate(_ string: String) -> String {
        return NSLocalizedString(string, comment: "")
    }
    
    public class func t(_ string: String) -> String {
        return NSLocalizedString(string, comment: "")
    }
    
    public class func t(_ string: String, comment: String) -> String {
        return NSLocalizedString(string, comment: "")
    }
}
