//
//  Rocket.swift
//  SpaceX
//
//  Created by Эван Крошкин on 29.08.22.
//

import Foundation

// MARK: - StarSpaceshipShip
struct Rocket: Codable {
    let height, diameter: Diameter
    let mass: Mass
    let firstStage: FirstStage
    let secondStage: SecondStage
    let engines: Engines
    let landingLegs: LandingLegs
    let payloadWeights: [PayloadWeight]
    let images: [String]
    let active: Bool
    let stages, boosters, costPerLaunch, successRate: Int
    let firstFlight, country, company, name, type, wikipedia, description, id: String

    enum CodingKeys: String, CodingKey {
        case height, diameter, mass
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case engines, id
        case landingLegs = "landing_legs"
        case payloadWeights = "payload_weights"
        case images = "flickr_images"
        case name, type, active, stages, boosters
        case costPerLaunch = "cost_per_launch"
        case successRate = "success_rate_pct"
        case firstFlight = "first_flight"
        case country, company, wikipedia
        case description = "description"
    }
}

