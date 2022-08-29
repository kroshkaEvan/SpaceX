//
//  ISP.swift
//  SpaceX
//
//  Created by Эван Крошкин on 29.08.22.
//

import Foundation

struct ISP: Codable {
    let seaLevel, vacuum: Int

    enum CodingKeys: String, CodingKey {
        case seaLevel = "sea_level"
        case vacuum
    }
}
