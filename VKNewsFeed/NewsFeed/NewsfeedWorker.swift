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
  
    private var newFromInProcess: String?
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
        fetcher.getFeed(nextBatchFrom: nil) { [weak self] feed in
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
    
    func getNextBatch(completion: @escaping ([Int], FeedResponse) -> Void) {
        newFromInProcess = feedResponse?.nextFrom
        fetcher.getFeed(nextBatchFrom: newFromInProcess) { [weak self] feedResponse in
            
            guard let feedResponse = feedResponse else {
                return
            }
            
            guard self?.feedResponse?.nextFrom != feedResponse.nextFrom else { return }
            
            if self?.feedResponse == nil {
                self?.feedResponse = feedResponse
            }
            else {
                self?.feedResponse?.items.append(contentsOf: feedResponse.items)
                self?.feedResponse?.nextFrom = feedResponse.nextFrom
                
                var profiles = feedResponse.profiles
                if let oldProfiles = self?.feedResponse?.profiles {
                    let oldProfilesFiltered = oldProfiles.filter { oldProfile -> Bool in
                        !feedResponse.profiles.contains(where: { $0.id == oldProfile.id
                        })
                    }
                    
                    profiles.append(contentsOf: oldProfilesFiltered)
                }
                self?.feedResponse?.profiles = profiles
                
                var groups = feedResponse.groups
                if let oldGroups = self?.feedResponse?.groups {
                    let oldGroupsFiltered = oldGroups.filter { oldGroup -> Bool in
                        !feedResponse.groups.contains(where: { $0.id == oldGroup.id
                        })
                    }
                    
                    groups.append(contentsOf: oldGroupsFiltered)
                }
                self?.feedResponse?.groups = groups
            }
            
            guard let feedResponse = self?.feedResponse else
            {
                return
            }
            
            completion(self!.revealPostIds, feedResponse)
        }
    }
}
