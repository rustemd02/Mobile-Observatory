//
//  ArticleTableViewCell.swift
//  Mobile-Observatory
//
//  Created by Рустем on 26.03.2022.
//

import UIKit
import SwiftUI

protocol SavePostButtonDelegate {
    func savePost(post: Post)
    func removePostFromSaved(post: Post)
}

class ArticleTableViewCell: UITableViewCell {
    
    var sourceLabel = UILabel()
    var createdAtLabel = UILabel()
    var titleLabel = UILabel()
    var summaryLabel = UILabel()
    var likeButton = UIButton()
    var article: Article?
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
        contentView.addSubview(likeButton)
        
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
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(summaryLabel.snp_bottomMargin).offset(12)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func configure(delegate: SavePostButtonDelegate?) {
        self.savePostsButtonDelegate = delegate
        
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
        if (article?.isSaved ?? false) {
            likeButton.setTitle("Понравилось", for: .normal)
            //likeButton.titleLabel?.textColor = .link
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setTitle("Нравится", for: .normal)
            //likeButton.titleLabel?.textColor = .link
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
        let saved = article?.isSaved ?? false
        article?.isSaved = !saved
        
        if (article?.isSaved ?? false) {
            savePostsButtonDelegate?.savePost(post: article!)
        } else {
            savePostsButtonDelegate?.removePostFromSaved(post: article!)
        }
        updateSaveButtonView()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
