//
//  String+Extension.swift
//  Pods
//
//  Created by Alex Zdorovets on 6/7/16.
//
//

// extension String: AnyType, DatabaseRepresentable {
//     //MARK: - AnyType
//     public var rawType: String { return "String" }

//     //MARK: - DatabaseRepresentable
//     public var dbValue: AnyType { return "'\(self)'" }
// }

public extension String {
    var untrim: String {
        var untrimmed = ""
        if !self.hasPrefix(" ") {
            untrimmed = " " + self
        }
        if !self.hasSuffix(" ") {
            untrimmed = self + " "
        }
        return untrimmed
    }
    
    public func wrap(char: String) -> String {
        return char + self + char
    }
    
    public var embrace: String {
        return "(" + self + ")"
    }
}

public extension String {
    var camelString: String {
        return self.characters.split("_").map({ return String($0).capitalizedString }).joinWithSeparator("").lowercaseFirst
    }
    
    var sneakyString: String {
        let regex = try? NSRegularExpression(pattern: "([a-z])([A-Z])", options: NSRegularExpressionOptions.AllowCommentsAndWhitespace)
        let value = regex?.stringByReplacingMatchesInString(self, options: .ReportCompletion, range: NSRange(location: 0, length: self.characters.count), withTemplate: "$1_$2")
        if let result = value where result.isEmpty == false {
            return result.lowercaseString
        }
        return self
    }
    
    var first: String { return String(characters.prefix(1)) }
    var last: String { return String(characters.suffix(1)) }
    
    var uppercaseFirst: String { return first.uppercaseString + String(characters.dropFirst()) }
    var lowercaseFirst: String { return first.lowercaseString + String(characters.dropFirst()) }
}

public extension String {
    var quoted: String {
        var result = ""
        if self.hasPrefix("'") == false {
            result += "'"
        }
        result += self
        if self.hasSuffix("'") == false {
            result += "'"
        }
        return result
    }
}