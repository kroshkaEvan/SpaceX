//
//  Diameter.swift
//  SpaceX
//
//  Created by Эван Крошкин on 29.08.22.
//

import Foundation

struct Diameter: Codable {
    let meters, feet: Double?
}

struct CompositeFairing: Codable {
    let height, diameter: Diameter
}
