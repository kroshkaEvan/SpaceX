//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Эван Крошкин on 29.08.22.
//

import Foundation
import Alamofire

protocol Networkble {
    func fetchRockets(completion: @escaping CompletionClosure)
}

typealias CompletionClosure = ((Result<[Spaceship], NetworkError>) -> Void)

class NetworkManager: Networkble {
    static let shared = NetworkManager()
        
    func fetchRockets(completion: @escaping CompletionClosure) {
        let baseUrl = "https://api.spacexdata.com/v4/rockets"
                
        AF.sessionConfiguration.timeoutIntervalForRequest = 50
        AF.request(baseUrl,
                   method: .get,
                   encoding: URLEncoding.default)
            .validate(statusCode: 200..<299)
            .validate(contentType: ["application/json"])
            .responseData { (responseData) in
                guard let response = responseData.response
                else { return completion(.failure(.serverError)) }
                
                switch response.statusCode {
                case 300...399:
                    completion(.failure(.badURL))
                case 400...499:
                    completion(.failure(.badRequest))
                case 500...599:
                    completion(.failure(.noInternet))
                default:
                    completion(.failure(.badURL))
                }
            }
            .responseDecodable(of: Spaceship.self) { (response) in
                guard let rockets = response.value
                else { return completion(.failure(.badJSON)) }
                completion(.success([rockets]))
            }
    }
}

