//
//  GalleryCollectionView.swift
//  VKNewsFeed
//
//  Created by Алексей Черанёв on 08.09.2021.
//

import UIKit
class GalleryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var photos = [FeedCellPhotoAttachmentViewModel]()
    
    init() {
        let rowLayout = RowLayout()
        super.init(frame: CGRect.zero, collectionViewLayout: rowLayout)
        
        rowLayout.delegate = self
        
        
        delegate = self
        dataSource = self
        
        backgroundColor = .white
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(photos: [FeedCellPhotoAttachmentViewModel]) {
        self.photos = photos
        contentOffset = CGPoint.zero
        reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as! GalleryCollectionViewCell
        
        cell.set(imageUrl:photos[indexPath.row].photoUrlString)
        
        return cell
    }
}

extension GalleryCollectionView: RowLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let width = photos[indexPath.row].width
        let height = photos[indexPath.row].height
        
        return CGSize(width: width, height: height)
    }
    
}
