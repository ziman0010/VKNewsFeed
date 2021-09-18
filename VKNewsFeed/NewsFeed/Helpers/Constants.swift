//
//  Constants.swift
//  VKNewsFeed
//
//  Created by Алексей Черанёв on 04.09.2021.
//

import UIKit

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 50
    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 9, bottom: 8, right: 9)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight = CGFloat(47)
    static let bottomViewViewHeight = CGFloat(47)
    static let bottomViewViewWidth = CGFloat(80)
    
    static let bottomViewViewsIconSize = CGFloat(24)
    
    static let minifiedPostLimitLines = CGFloat(8)
    static let minifiedPostLines = CGFloat(6)
    static let moreTextButtonSize = CGSize(width: 170, height: 30)
    static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
}

