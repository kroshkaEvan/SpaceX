//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Эван Крошкин on 29.08.22.
//

import Foundation
import Alamofire

typealias RocketCompletionClosure = ((Result<[Rocket], NetworkError>) -> Void)
typealias LaunchCompletionClosure = ((Result<[Launch], NetworkError>) -> Void)

protocol Networkble {
    func getData<T: Decodable>(url: String,
                               endPoint: URL.EndPoint,
                               completion: @escaping (Result<T, NetworkError>) -> Void)
    func fetchRockets(completion: @escaping RocketCompletionClosure)
    func fetchLaunches(completion: @escaping LaunchCompletionClosure)

}

class NetworkManager: Networkble {
    static let shared = NetworkManager()
    
    func getData<T: Decodable>(url: String,
                               endPoint: URL.EndPoint,
                               completion: @escaping (Result<T, NetworkError>) -> Void) {
        let url = "\(URL.baseURL)\(endPoint)"
        AF.sessionConfiguration.timeoutIntervalForRequest = 50
        AF.request(url,
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
            .responseDecodable(of: T.self) { (response) in
                guard let model = response.value
                else { return completion(.failure(.badJSON)) }
                completion(.success(model))
            }
    }
    
    func fetchRockets(completion: @escaping RocketCompletionClosure) {
        getData(url: URL.baseURL,
                endPoint: URL.EndPoint.rockets,
                completion: completion)
    }
    
    func fetchLaunches(completion: @escaping LaunchCompletionClosure) {
        getData(url: URL.baseURL,
                endPoint: URL.EndPoint.launches,
                completion: completion)
    }
}

