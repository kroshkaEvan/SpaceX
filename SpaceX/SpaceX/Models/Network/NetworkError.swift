//
//  NetworkError.swift
//  SpaceX
//
//  Created by Эван Крошкин on 29.08.22.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case badURL, badRequest, noInternet, badJSON, serverError
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Invalid URL."
        case .badRequest:
            return "Invalid Request."
        case .noInternet:
            return "Сheck internet connection."
        case .badJSON:
            return "Can't load data."
        case .serverError:
            return "Server not responding."
        }
    }
}

