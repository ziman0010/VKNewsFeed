//
//  FeedViewController.swift
//  VKNewsFeed
//
//  Created by Алексей Черанёв on 23.08.2021.
//

import UIKit

class FeedViewController: UIViewController {
    private let networkService: Networking = NetworkService()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        let params = ["filters" : "post, photo"]
        networkService.request(path: API.newsFeed, params: params) { data, error in
            if let error = error
            {
                print("Error: \(error.localizedDescription)")
            }
            
            guard let data = data else { return }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        }
    }
}
