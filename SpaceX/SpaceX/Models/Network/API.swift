//
//  API.swift
//  SpaceX
//
//  Created by Эван Крошкин on 31.08.22.
//

import Foundation

struct API {
    static let baseURL = "https://api.spacexdata.com/v4/"
    
    enum EndPoint: String {
        case rockets = "rockets"
        case launches = "launches"
    }
}
