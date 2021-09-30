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
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        
        switch request {
        case .getNewsFeed:
            service?.getFeed(completion: { [weak self] feed, revealPostIds in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealPostIds))
            })
        case .getUser:
            service?.getUser(completion: { [weak self]  userResponse in
                self?.presenter?.presentData(response: .presentUserInfo(response: userResponse))
            })
        case .revealPost(postId: let postId):
            service?.revealPostIds(forPostId: postId, completion: { [weak self] feedResponse, revealPostIds in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealedPostIds: revealPostIds))
            })
        case .getNextBatch:
            self.presenter?.presentData(response: .presentFooterLoader)
            service?.getNextBatch(completion: { revealedPostIds, feedResponse in
                self.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealedPostIds: revealedPostIds))
            })
        }
    }
}
