//
//  ArticleTableViewCell.swift
//  Mobile-Observatory
//
//  Created by Рустем on 26.03.2022.
//

import UIKit
import SwiftUI

class ArticleTableViewCell: UITableViewCell {
    
    var sourceLabel = UILabel()
    var createdAtLabel = UILabel()
    var titleLabel = UILabel()
    var summaryLabel = UILabel()
    var likeButton = UIButton()
    var likeView = UIView()
    var article: Article?
    var index: IndexPath?
    
    let likeColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    let likeBackgroundColor = #colorLiteral(red: 0.8539047241, green: 0.8987153172, blue: 0.8979462981, alpha: 1)
    private var savePostsButtonDelegate: SavePostButtonDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        uiInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func uiInit() {
        contentView.addSubview(sourceLabel)
        contentView.addSubview(createdAtLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(summaryLabel)
        
        contentView.addSubview(likeView)
        likeView.addSubview(likeButton)
        
        sourceLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(16)
        }
        
        createdAtLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        createdAtLabel.textColor = .separator
        createdAtLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(createdAtLabel.snp_bottomMargin).offset(12)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        
        summaryLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        summaryLabel.numberOfLines = 5
        summaryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(12)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        
        likeView.backgroundColor = likeBackgroundColor
        likeView.layer.cornerRadius = 13
        likeView.clipsToBounds = true
        likeView.snp.makeConstraints { make in
            make.top.equalTo(summaryLabel.snp_bottomMargin).offset(20)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(30)
        }
        
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        likeButton.setTitleColor(likeColor, for: .normal)
        likeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        likeButton.snp.makeConstraints { make in
            make.top.left.equalTo(likeView).offset(8)
            make.bottom.right.equalTo(likeView).inset(8)
            
        }
    }
    
    func configure(delegate: SavePostButtonDelegate?, index: IndexPath) {
        self.savePostsButtonDelegate = delegate
        self.index = index
        self.titleLabel.text = article?.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let stringDate = dateFormatter.string(from: article?.createdAt ?? Date())
        self.createdAtLabel.text = stringDate
        
        self.sourceLabel.text = article?.newsSite
        self.summaryLabel.text = article?.summary
        
        updateSaveButtonView()
    }
    
    func updateSaveButtonView() {
        let likedImage = UIImage(systemName: "heart.fill")?.withTintColor(likeColor, renderingMode: .alwaysOriginal)
        let unlikedImage = UIImage(systemName: "heart")?.withTintColor(likeColor, renderingMode: .alwaysOriginal)
        if (article?.isSaved ?? false) {
            likeButton.setTitle(" Понравилось", for: .normal)
            likeButton.setImage(likedImage, for: .normal)
        } else {
            likeButton.setTitle("Нравится", for: .normal)
            likeButton.setImage(unlikedImage, for: .normal)
        }
        likeButton.imageView?.contentMode = .scaleAspectFit
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
        let saved = article?.isSaved ?? false
        article?.isSaved = !saved
        
        if (article?.isSaved ?? false) {
            savePostsButtonDelegate?.savePost(post: article!, index: index)
        } else {
            savePostsButtonDelegate?.removePostFromSaved(post: article!, index: index)
        }
        updateSaveButtonView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
