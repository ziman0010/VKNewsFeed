//
//  FeedViewController.swift
//  VKNewsFeed
//
//  Created by Алексей Черанёв on 23.08.2021.
//

import UIKit

class FeedViewController: UIViewController {
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        fetcher.getFeed { feedResponse in
            guard let feedResponse = feedResponse else {
                return
            }
            feedResponse.items.map { feedItem in
                print(feedItem.date)
            }
        }
    }
}
