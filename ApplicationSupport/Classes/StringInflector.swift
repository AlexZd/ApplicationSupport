//
//  StringInflector.swift
//  Pods
//
//  Created by Vlad Gorbenko on 7/26/16.
//
//

import Foundation

public extension String {
    public var pluralized: String { return StringInflector.sharedInstance.pluralize(self) }
    public var singularized: String { return StringInflector.sharedInstance.singularize(self) }
}

public class StringInflector {
    public struct Rule {
        public enum Form {
            case Singular
            case Plural
        }
        
        let replacement: String
        let regex: NSRegularExpression?
        
        public init(pattern: String, options: NSRegularExpressionOptions, replacement: String) {
            self.regex = try? NSRegularExpression(pattern: pattern, options: options)
            self.replacement = replacement
        }
        
        public func evaluate(inout string: String) -> Bool {
            let range = NSRange(location: 0, length: string.characters.count)
            let mutableString = NSMutableString(string: string)
            let result = self.regex?.replaceMatchesInString(mutableString, options: NSMatchingOptions.ReportProgress, range: range, withTemplate: self.replacement)
            string = String(mutableString)
            return result != 0
        }
    }
    
    
    public static let sharedInstance = StringInflector.defaultInflector()
    
    public var singularRules: [Rule] = []
    public var pluralRules: [Rule] = []
    public var uncountable = Set<String>()
    public var irregular: [String: String] = [:]
    
    //MARK: -
    
    private class func defaultInflector() -> StringInflector {
        let inflector = StringInflector()
        inflector.predefinedEnUSLocale()
        return inflector
    }
    
    //MARK: -
    
    public func singularize(string: String) -> String { return _lize(string, rules: self.singularRules) }
    public func pluralize(string: String) -> String { return _lize(string, rules: self.pluralRules) }
    
    private func _lize(string: String, rules: [Rule]) -> String {
        if self.uncountable.contains(string) {
            return String(string)
        }
        let irregular = self.irregular.keys.filter({ $0 == string })
        if !irregular.isEmpty {
            return String(irregular.first!)
        }
        var result = String(string)
        for rule in rules {
            if rule.evaluate(&result) {
                return result
            }
        }
        return result
    }
    
    //MARK: - Rules
    
    public func add(form: Rule.Form, pattern: String, replacement: String) {
        self.uncountable.remove(pattern)
        let rule = Rule(pattern: pattern, options: [.AnchorsMatchLines, .CaseInsensitive, .UseUnicodeWordBoundaries], replacement: replacement)
        if form == .Singular {
            self.singularRules.append(rule)
        } else {
            self.uncountable.remove(replacement)
            self.pluralRules.append(rule)
        }
    }
    public func add(irregular singular: String, plural: String) {
        self.irregular[singular] = plural
        self.irregular[singular.capitalizedString] = plural.capitalizedString
    }
    public func add(uncountable word: String) {
        self.uncountable.insert(word)
    }
    
    // MARK: Utils
    
    private func predefinedEnUSLocale() {
        self.add(.Plural, pattern: "$", replacement: "s")
        self.add(.Plural, pattern: "s$", replacement: "s")
        self.add(.Plural, pattern: "^(ax|test)is$", replacement: "$1es")
        self.add(.Plural, pattern: "(octop|vir)us$", replacement: "$1i")
        self.add(.Plural, pattern: "(octop|vir)i$", replacement: "$1i")
        self.add(.Plural, pattern: "(alias|status)$", replacement: "$1es")
        self.add(.Plural, pattern: "(bu)s$", replacement: "$1ses")
        self.add(.Plural, pattern: "(buffal|tomat)o$", replacement: "$1oes")
        self.add(.Plural, pattern: "([ti])um$", replacement: "$1a")
        self.add(.Plural, pattern: "([ti])a$", replacement: "$1a")
        self.add(.Plural, pattern: "sis$", replacement: "ses")
        self.add(.Plural, pattern: "(?:([^f])fe|([lr])f)$", replacement: "$1$2ves")
        self.add(.Plural, pattern: "(hive)$", replacement: "$1s")
        self.add(.Plural, pattern: "([^aeiouy]|qu)y$", replacement: "$1ies")
        self.add(.Plural, pattern: "(x|ch|ss|sh)$", replacement: "$1es")
        self.add(.Plural, pattern: "(matr|vert|ind)(?:ix|ex)$", replacement: "$1ices")
        self.add(.Plural, pattern: "^(m|l)ouse$", replacement: "$1ice")
        self.add(.Plural, pattern: "^(m|l)ice$", replacement: "$1ice")
        self.add(.Plural, pattern: "^(ox)$", replacement: "$1en")
        self.add(.Plural, pattern: "^(oxen)$", replacement: "$1")
        self.add(.Plural, pattern: "(quiz)$", replacement: "$1zes")
        
        self.add(.Singular, pattern: "s$", replacement: "")
        self.add(.Singular, pattern: "(ss)$", replacement: "$1")
        self.add(.Singular, pattern: "(n)ews$", replacement: "$1ews")
        self.add(.Singular, pattern: "([ti])a$", replacement: "$1um")
        self.add(.Singular, pattern: "([^f])ves$", replacement: "$1fe")
        self.add(.Singular, pattern: "(hive)s$", replacement: "$1")
        self.add(.Singular, pattern: "(tive)s$", replacement: "$1")
        self.add(.Singular, pattern: "([lr])ves$", replacement: "$1f")
        self.add(.Singular, pattern: "([^aeiouy]|qu)ies$", replacement: "$1y")
        self.add(.Singular, pattern: "(s)eries$", replacement: "$1eries")
        self.add(.Singular, pattern: "(m)ovies$", replacement: "$1ovie")
        self.add(.Singular, pattern: "(x|ch|ss|sh)es$", replacement: "$1")
        self.add(.Singular, pattern: "^(m|l)ice$", replacement: "$1ouse")
        self.add(.Singular, pattern: "(bus)(es)?$", replacement: "$1")
        self.add(.Singular, pattern: "(o)es$", replacement: "$1")
        self.add(.Singular, pattern: "(shoe)s$", replacement: "$1")
        self.add(.Singular, pattern: "(cris|test)(is|es)$", replacement: "$1is")
        self.add(.Singular, pattern: "^(a)x[ie]s$", replacement: "$1xis")
        self.add(.Singular, pattern: "(octop|vir)(us|i)$", replacement: "$1us")
        self.add(.Singular, pattern: "(alias|status)(es)?$", replacement: "$1")
        self.add(.Singular, pattern: "^(ox)en", replacement: "$1")
        self.add(.Singular, pattern: "(vert|ind)ices$", replacement: "$1ex")
        self.add(.Singular, pattern: "(matr)ices$", replacement: "$1ix")
        self.add(.Singular, pattern: "(quiz)zes$", replacement: "$1")
        self.add(.Singular, pattern: "(database)s$", replacement: "$1")
        
        self.add(uncountable:"equipment")
        self.add(uncountable:"information")
        self.add(uncountable:"rice")
        self.add(uncountable:"money")
        self.add(uncountable:"species")
        self.add(uncountable:"series")
        self.add(uncountable:"fish")
        self.add(uncountable:"sheep")
        self.add(uncountable:"jeans")
    }
    
}