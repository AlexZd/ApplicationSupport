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

open class StringInflector {
    public struct Rule {
        public enum Form {
            case singular
            case plural
        }
        
        let replacement: String
        let pattern: String
        let regex: NSRegularExpression
        
        public init(pattern: String, options: NSRegularExpression.Options, replacement: String) {
            self.pattern = pattern
            self.regex = try! NSRegularExpression(pattern: pattern, options: options)
            self.replacement = replacement
        }
        
        public func evaluate(_ string: inout String) -> Bool {
            let range = NSRange(location: 0, length: string.characters.count)
            let mutableString = NSMutableString(string: string)
            let result = self.regex.replaceMatches(in: mutableString, options: [], range: range, withTemplate: self.replacement)
            if result != 0 {
                string = String(mutableString)
            }
            return result != 0
        }
    }
    
    
    open static let sharedInstance = StringInflector.defaultInflector()
    
    open var singularRules: [Rule] = []
    open var pluralRules: [Rule] = []
    open var uncountable = Set<String>()
    open var irregular: [String: String] = [:]
    
    //MARK: -
    
    fileprivate class func defaultInflector() -> StringInflector {
        let inflector = StringInflector()
        inflector.predefinedEnUSLocale()
        return inflector
    }
    
    //MARK: -
    
    open func singularize(_ string: String) -> String { return _lize(string, rules: self.singularRules) }
    open func pluralize(_ string: String) -> String { return _lize(string, rules: self.pluralRules) }
    
    fileprivate func _lize(_ string: String, rules: [Rule]) -> String {
        if self.uncountable.contains(string) {
            return String(string)
        }
        let irregular = self.irregular.keys.filter({ $0 == string })
        if !irregular.isEmpty {
            return String(irregular.first!)
        }
        var result = String(string)
        for rule in rules.reversed() {
            if rule.evaluate(&result) {
                return result
            }
        }
        return result
    }
    
    //MARK: - Rules
    
    open func add(_ form: Rule.Form, pattern: String, replacement: String) {
        self.uncountable.remove(pattern)
        let rule = Rule(pattern: pattern, options: [.anchorsMatchLines, .caseInsensitive, .useUnicodeWordBoundaries], replacement: replacement)
        if form == .singular {
            self.singularRules.append(rule)
        } else {
            self.uncountable.remove(replacement)
            self.pluralRules.append(rule)
        }
    }
    open func add(irregular singular: String, plural: String) {
        self.irregular[singular] = plural
        self.irregular[singular.capitalized] = plural.capitalized
    }
    open func add(uncountable word: String) {
        self.uncountable.insert(word)
    }
    
    // MARK: Utils
    
    fileprivate func predefinedEnUSLocale() {
        self.add(.plural, pattern: "$", replacement: "s")
        self.add(.plural, pattern: "s$", replacement: "s")
        self.add(.plural, pattern: "^(ax|test)is$", replacement: "$1es")
        self.add(.plural, pattern: "(octop|vir)us$", replacement: "$1i")
        self.add(.plural, pattern: "(octop|vir)i$", replacement: "$1i")
        self.add(.plural, pattern: "(alias|status)$", replacement: "$1es")
        self.add(.plural, pattern: "(bu)s$", replacement: "$1ses")
        self.add(.plural, pattern: "(buffal|tomat)o$", replacement: "$1oes")
        self.add(.plural, pattern: "([ti])um$", replacement: "$1a")
        self.add(.plural, pattern: "([ti])a$", replacement: "$1a")
        self.add(.plural, pattern: "sis$", replacement: "ses")
        self.add(.plural, pattern: "(?:([^f])fe|([lr])f)$", replacement: "$1$2ves")
        self.add(.plural, pattern: "(hive)$", replacement: "$1s")
        self.add(.plural, pattern: "([^aeiouy]|qu)y$", replacement: "$1ies")
        self.add(.plural, pattern: "(x|ch|ss|sh)$", replacement: "$1es")
        self.add(.plural, pattern: "(matr|vert|ind)(?:ix|ex)$", replacement: "$1ices")
        self.add(.plural, pattern: "^(m|l)ouse$", replacement: "$1ice")
        self.add(.plural, pattern: "^(m|l)ice$", replacement: "$1ice")
        self.add(.plural, pattern: "^(ox)$", replacement: "$1en")
        self.add(.plural, pattern: "^(oxen)$", replacement: "$1")
        self.add(.plural, pattern: "(quiz)$", replacement: "$1zes")
        
        self.add(.singular, pattern: "s$", replacement: "")
        self.add(.singular, pattern: "(ss)$", replacement: "$1")
        self.add(.singular, pattern: "(n)ews$", replacement: "$1ews")
        self.add(.singular, pattern: "([ti])a$", replacement: "$1um")
        self.add(.singular, pattern: "([^f])ves$", replacement: "$1fe")
        self.add(.singular, pattern: "(hive)s$", replacement: "$1")
        self.add(.singular, pattern: "(tive)s$", replacement: "$1")
        self.add(.singular, pattern: "([lr])ves$", replacement: "$1f")
        self.add(.singular, pattern: "([^aeiouy]|qu)ies$", replacement: "$1y")
        self.add(.singular, pattern: "(s)eries$", replacement: "$1eries")
        self.add(.singular, pattern: "(m)ovies$", replacement: "$1ovie")
        self.add(.singular, pattern: "(x|ch|ss|sh)es$", replacement: "$1")
        self.add(.singular, pattern: "^(m|l)ice$", replacement: "$1ouse")
        self.add(.singular, pattern: "(bus)(es)?$", replacement: "$1")
        self.add(.singular, pattern: "(o)es$", replacement: "$1")
        self.add(.singular, pattern: "(shoe)s$", replacement: "$1")
        self.add(.singular, pattern: "(cris|test)(is|es)$", replacement: "$1is")
        self.add(.singular, pattern: "^(a)x[ie]s$", replacement: "$1xis")
        self.add(.singular, pattern: "(octop|vir)(us|i)$", replacement: "$1us")
        self.add(.singular, pattern: "(alias|status)(es)?$", replacement: "$1")
        self.add(.singular, pattern: "^(ox)en", replacement: "$1")
        self.add(.singular, pattern: "(vert|ind)ices$", replacement: "$1ex")
        self.add(.singular, pattern: "(matr)ices$", replacement: "$1ix")
        self.add(.singular, pattern: "(quiz)zes$", replacement: "$1")
        self.add(.singular, pattern: "(database)s$", replacement: "$1")
        
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
