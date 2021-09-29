//
//  NewsfeedWorker.swift
//  VKNewsFeed
//
//  Created by Алексей Черанёв on 26.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NewsfeedService {

    var authService: AuthService
    var networking: Networking
    var fetcher: DataFetcher
    
    private var feedResponse: FeedResponse?
    private var revealPostIds = [Int]()
  
    init() {
        self.authService = SceneDelegate.shared().authService
        self.networking = NetworkService(authService: authService)
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    
    func getUser(completion: @escaping (UserResponse?) -> Void) {
        fetcher.getUser { userResponse in
            completion(userResponse)
        }
    }
    
    func getFeed(completion: @escaping (FeedResponse, [Int]) -> Void) {
        fetcher.getFeed { [weak self] feed in
            self?.feedResponse = feed
            guard let feedResponse = self?.feedResponse else {
                return
            }
            completion(feedResponse, self!.revealPostIds)
        }
    }
    
    func revealPostIds (forPostId postId: Int, completion: @escaping (FeedResponse, [Int]) -> Void) {
        revealPostIds.append(postId)
        guard  let feedResponse = feedResponse else {
            return
        }
        completion(feedResponse, revealPostIds)
    }
}
