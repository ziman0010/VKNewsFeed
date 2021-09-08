//
//  NewsfeedCellLayoutCalculator.swift
//  VKNewsFeed
//
//  Created by Алексей Черанёв on 02.09.2021.
//

import UIKit

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var moreTextButtonFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
    
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes (postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?, isFullSizedPost: Bool) -> FeedCellSizes
}
final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes (postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?, isFullSizedPost: Bool) -> FeedCellSizes {
        
        var showMoreTextButton = false
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        //Mark: - Working with postLabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: .zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = text.height(width: width, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
            
            if !isFullSizedPost && height > limitHeight
            {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //Mark: - Working with moreTextButtonFrame
        
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
        
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        
        //Mark: - Working with attachmentFrame
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        
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
        
        let totalHeight = bottomViewTop + Constants.bottomViewViewHeight + Constants.cardInsets.bottom
        
        
        return Sizes(postLabelFrame: postLabelFrame, moreTextButtonFrame: moreTextButtonFrame, attachmentFrame: attachmentFrame, bottomViewFrame: bottomViewFrame, totalHeight: totalHeight)
    }
}
