//
//  NewsfeedCellLayoutCalculator.swift
//  VKNewsFeed
//
//  Created by Алексей Черанёв on 02.09.2021.
//

import UIKit

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
    
}

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 36
    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 9, bottom: 8, right: 9)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight = CGFloat(47)
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes (postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}
final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes (postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        //Mark: - Working with postLabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: .zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            let height = text.height(width: width, font: Constants.postLabelFont)
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //Mark: - Working with attachmentFrame
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : postLabelFrame.maxY + Constants.postLabelInsets.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        
        if let attachment = photoAttachment {
            
            let photoHeight = Float(attachment.height)
            let photoWidth = Float(attachment.width)
            let ratio = photoHeight / photoWidth
            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * CGFloat(ratio))
        }
        
        //Mark: - Working with bottomViewFrame
        
        let bottomViewTop = postLabelFrame.maxY >  attachmentFrame.maxY ? postLabelFrame.maxY : attachmentFrame.maxY + 8
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        let totalHeight = bottomViewTop + Constants.bottomViewHeight + Constants.cardInsets.bottom
        
        return Sizes(postLabelFrame: postLabelFrame, attachmentFrame: attachmentFrame, bottomViewFrame: bottomViewFrame, totalHeight: totalHeight)
    }
}
