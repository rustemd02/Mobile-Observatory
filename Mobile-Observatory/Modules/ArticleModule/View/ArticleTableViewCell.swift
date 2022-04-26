//
//  ArticleTableViewCell.swift
//  Mobile-Observatory
//
//  Created by Рустем on 26.03.2022.
//

import UIKit
import SwiftUI

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    var article: Article?
    private var savePostsButtonDelegate: SavePostButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else{
            likeButton.setTitle("Нравится", for: .normal)
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
