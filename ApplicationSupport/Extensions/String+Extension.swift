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
    
    public func wrap(_ char: String) -> String {
        return char + self + char
    }
    
    public var embrace: String {
        return "(" + self + ")"
    }
}

public extension String {
    var camelString: String {
        return self.characters.split(separator: "_").map({ return String($0).capitalized }).joined(separator: "").lowercaseFirst
    }
    
    var sneakyString: String {
        let regex = try? NSRegularExpression(pattern: "([a-z])([A-Z])", options: NSRegularExpression.Options.allowCommentsAndWhitespace)
        let value = regex?.stringByReplacingMatches(in: self, options: .reportCompletion, range: NSRange(location: 0, length: self.characters.count), withTemplate: "$1_$2")
        if let result = value , result.isEmpty == false {
            return result.lowercased()
        }
        return self
    }
    
    var first: String { return String(characters.prefix(1)) }
    var last: String { return String(characters.suffix(1)) }
    
    var uppercaseFirst: String { return first.uppercased() + String(characters.dropFirst()) }
    var lowercaseFirst: String { return first.lowercased() + String(characters.dropFirst()) }
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
