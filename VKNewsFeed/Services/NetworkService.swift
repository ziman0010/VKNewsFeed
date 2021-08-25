//
//  NetworkService.swift
//  VKNewsFeed
//
//  Created by Алексей Черанёв on 24.08.2021.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String : String], completion : @escaping (Data?, Error?) -> ())
}
final class NetworkService: Networking {
    
    init() {
        self.authService = SceneDelegate.shared().authService
    }
    private let authService: AuthService
    
    private func url(from path: String, params: [String : String]) -> URL {
        
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map({
            URLQueryItem(name: $0, value: $1)
        })
        
        return components.url!
    }
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> ()) {
        guard let token = authService.token else {
            return
        }
        var allparams = params
        allparams["access_token"] = token
        allparams["v"] = API.version
        let url = url(from: path, params: allparams)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> ()) -> URLSessionDataTask {
        
        
        return URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        
    }
}
