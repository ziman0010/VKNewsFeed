//
//  WebImageView.swift
//  VKNewsFeed
//
//  Created by Алексей Черанёв on 01.09.2021.
//

import UIKit

class WebImageView: UIImageView {
    func set(imageUrl: String) {
        guard let url = URL(string: imageUrl) else
        {
            return
        }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url))
        {
            self.image = UIImage(data: cachedResponse.data)
            print("from cache")
            return
        }
        
        print("from int")
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let data = data, let response = response
                {
                    self?.image = UIImage(data: data)
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        
        dataTask.resume()
        
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else {
            return
        }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
