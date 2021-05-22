//
//  APIService.swift
//  SuperRun (iOS)
//
//  Created by DerouicheElyes on 22/5/2021.
//

import Foundation
import Combine

class APIService {
    static let shared = APIService()
    
    private init () { }
    
    private enum ServiceError: Error {
        case url(URLError)
        case urlRequest
        case decode
        case error(String)
    }
    
    func get <T:Codable> (of type :T.Type, from url : String) -> AnyPublisher<T,Error> {
        
        var dataTask : URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = {
            dataTask?.cancel()
        }
        
        return Future<T,Error> { promise in
            
            guard let url = URL(string: url) else {
                promise(.failure(ServiceError.urlRequest) )
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            print(url)
            dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let _ = error {
                    promise(.failure(error!))
                }
                
                guard let data = data else {
                    promise(.failure(ServiceError.decode))
                    return
                }
                //                TODO: Check for httpresponse code before proceeding to Encoder
                do {
                    let object = try JSONDecoder().decode(T.self, from : data)
                    
                    promise(.success(object))
                    
                } catch {
                    promise (.failure(ServiceError.decode))
                }
            })
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
}
