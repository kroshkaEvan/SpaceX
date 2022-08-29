//
//  Thrust.swift
//  SpaceX
//
//  Created by Эван Крошкин on 29.08.22.
//

import Foundation

struct Thrust: Codable {
    let kN, lbf: Int
}

struct Payloads: Codable {
    let compositeFairing: CompositeFairing
    let option1: String

    enum CodingKeys: String, CodingKey {
        case compositeFairing = "composite_fairing"
        case option1 = "option_1"
    }
}
