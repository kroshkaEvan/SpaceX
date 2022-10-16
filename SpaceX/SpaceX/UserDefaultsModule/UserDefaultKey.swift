//
//  UserDefaultKey.swift
//  SpaceX
//
//  Created by Эван Крошкин on 15.09.22.
//

import Foundation

struct UserDefaultKey: RawRepresentable {
    let rawValue: String
}

extension UserDefaultKey: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        rawValue = value
    }
}
