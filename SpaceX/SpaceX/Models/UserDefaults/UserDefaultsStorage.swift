//
//  UserDefaultsStorage.swift
//  SpaceX
//
//  Created by Эван Крошкин on 15.09.22.
//

import Foundation

class UserDefaultsStorage {
    @StrongUserDefault(key: .height,
                       defaultValue: 0)
    var height: Int
    @StrongUserDefault(key: .diameter,
                       defaultValue: 0)
    var diameter: Int
    @StrongUserDefault(key: .mass,
                       defaultValue: 0)
    var mass: Int
    @StrongUserDefault(key: .payload,
                       defaultValue: 0)
    var payload: Int
}

private extension UserDefaultKey {
    static let height: UserDefaultKey = "height"
    static let diameter: UserDefaultKey = "diameter"
    static let mass: UserDefaultKey = "mass"
    static let payload: UserDefaultKey = "payload"
}

