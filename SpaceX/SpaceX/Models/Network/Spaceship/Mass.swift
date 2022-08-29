//
//  Mass.swift
//  SpaceX
//
//  Created by Эван Крошкин on 29.08.22.
//

import Foundation

struct Mass: Codable {
    let kg, lb: Int
}

struct PayloadWeight: Codable {
    let id, name: String
    let kg, lb: Int
}
