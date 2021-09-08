//
//  NewsfeedInteractor.swift
//  VKNewsFeed
//
//  Created by Алексей Черанёв on 26.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
  func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {

  var presenter: NewsfeedPresentationLogic?
  var service: NewsfeedService?
    
    private var feedResponse: FeedResponse?
    private var revealPostIds = [Int]()
  
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
  func makeRequest(request: Newsfeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsfeedService()
    }
    switch request {
    case .getNewsFeed:
        fetcher.getFeed { [weak self] feedResponse in
            self?.feedResponse = feedResponse
            self?.presentFeed()
        }
        
    case .revealPost(postId: let postId):
        revealPostIds.append(postId)
        presentFeed()
    }
  }
    
    private func presentFeed() {
        guard let feedResponse = feedResponse else {
            return
        }
        presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealedPostIds: revealPostIds))
    }
  
}
