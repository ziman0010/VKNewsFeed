//
//  NewsfeedCodeCell.swift
//  VKNewsFeed
//
//  Created by Алексей Черанёв on 03.09.2021.
//

import UIKit

protocol NewsfeedCodeCellDelegate: AnyObject {
    func revealPost(for cell: NewsfeedCodeCell)
}
final class NewsfeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCodeCell"
    
    weak var delegate: NewsfeedCodeCellDelegate?
    //first layer
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    //second layer
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    let postLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.font = Constants.postLabelFont
//
//        return label
//    }()
    
    let postLabel: UITextView = {
        let textView = UITextView()
        textView.font = Constants.postLabelFont
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets.init(top: 0, left: -padding, bottom: 0, right: -padding)
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        return textView
    }()
    
    let galleryCollectionView = GalleryCollectionView()
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        
        return imageView
    }()
    
    let bottomView : UIView = {
        let view = UIView()
        // view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.4, green: 0.6235294118, blue: 0.831372549, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полность...", for: .normal)
        return button
    }()
    
    //third layer on the top view
    
    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    //third layer on the bottomView
    
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Fourth layer on the bottomView
    
    let likesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    
    let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        return imageView
    }()
    
    let sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        return imageView
    }()
    
    let viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "eye")
        return imageView
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    override func prepareForReuse() {
        iconImageView.set(imageUrl: nil)
        postImageView.set(imageUrl: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconImageView.layer.cornerRadius = Constants.topViewHeight / 2
        iconImageView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchUpInside)
        
        
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayerOnTheTopView()
        overlayThirdLayerOnTheBottomView()
        overlayFourthLayerOnTheBottomView()
        
        cardView.isUserInteractionEnabled = true
        
        
        
    }
    
    
    
    @objc func moreTextButtonTouch() {
        delegate?.revealPost(for: self)
    }
    private func helpInFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {
        
        //imageView constraints
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.anchor(top: nil,
                         leading: view.leadingAnchor,
                         bottom: nil,
                         trailing: nil,
                         padding: UIEdgeInsets(top: 777, left: 10, bottom: 777, right: 777),
                         size: CGSize(width: Constants.bottomViewViewsIconSize, height: Constants.bottomViewViewsIconSize))
        //label constraints
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func overlayFourthLayerOnTheBottomView() {
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        
        helpInFourthLayer(view: likesView, imageView: likesImage, label: likesLabel)
        helpInFourthLayer(view: commentsView, imageView: commentsImage, label: commentsLabel)
        helpInFourthLayer(view: sharesView, imageView: sharesImage, label: sharesLabel)
        helpInFourthLayer(view: viewsView, imageView: viewsImage, label: viewsLabel)
        
        //
    }
    
    private func overlayThirdLayerOnTheBottomView() {
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
        //likes view constraints
        likesView.anchor(top: bottomView.topAnchor,
                         leading: bottomView.leadingAnchor,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        //commentsView constraints
        commentsView.anchor(top: bottomView.topAnchor,
                            leading: likesView.trailingAnchor,
                            bottom: nil,
                            trailing: nil,
                            size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        //sharesView constraints
        sharesView.anchor(top: bottomView.topAnchor,
                          leading: commentsView.trailingAnchor,
                          bottom: nil,
                          trailing: nil,
                          size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        //viewView constraints
        viewsView.anchor(top: bottomView.topAnchor,
                         leading: nil,
                         bottom: nil,
                         trailing: bottomView.trailingAnchor,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
    }
    
    
    private func overlayThirdLayerOnTheTopView() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        //iconImageView constraints
        iconImageView.anchor(top: topView.topAnchor, leading: topView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 777, right: 777))
        
        iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        //nameLabel constraints
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 3).isActive = true
        
        //dateLabel constraints
        
        dateLabel.anchor(top: nil, leading: iconImageView.trailingAnchor, bottom: topView.bottomAnchor, trailing: topView.trailingAnchor, padding: UIEdgeInsets(top: 777, left: 8, bottom: 2, right: 8))
        dateLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 3).isActive = true
        
    }
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        
        cardView.addSubview(postLabel)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(galleryCollectionView)
        
        cardView.addSubview(bottomView)
        
        //topView constraints
        topView.anchor(top: cardView.topAnchor,
                       leading: cardView.leadingAnchor,
                       bottom: nil,
                       trailing: cardView.trailingAnchor,
                       padding: UIEdgeInsets(top: 8,
                                             left: 8,
                                             bottom: 777,
                                             right: 8))
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        
    }
    
    private func overlayFirstLayer() {
        contentView.addSubview(cardView)
        
        //cardView constraints
        cardView.fillSuperview(padding: Constants.cardInsets)
       
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(viewModel: FeedCellViewModel) {
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        iconImageView.set(imageUrl: viewModel.iconURLString)
        
        postLabel.frame = viewModel.sizes.postLabelFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
      
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1
        {
            postImageView.set(imageUrl: photoAttachment.photoUrlString)
            postImageView.isHidden = false
            galleryCollectionView.isHidden = true
            postImageView.frame = viewModel.sizes.attachmentFrame
        }
        else if viewModel.photoAttachments.count > 1
        {
            galleryCollectionView.set(photos: viewModel.photoAttachments)
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
        }
        else
        {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
    }
}
