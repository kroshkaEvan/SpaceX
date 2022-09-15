//
//  UserDefault.swift
//  SpaceX
//
//  Created by Эван Крошкин on 15.09.22.
//

import Foundation

protocol PropertyListValue {}
extension String: PropertyListValue {}
extension Data: PropertyListValue {}
extension Date: PropertyListValue {}
extension Bool: PropertyListValue {}
extension Int: PropertyListValue {}
extension Double: PropertyListValue {}

@propertyWrapper
struct StrongUserDefault<T: PropertyListValue> {
    private let key: UserDefaultKey
    private let defaultValue: T
    
    init(key: UserDefaultKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get { UserDefaults.standard.value(forKey: key.rawValue) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key.rawValue) }
    }
}
