//
//  PictureFromMarsTableViewCell.swift
//  Mobile-Observatory
//
//  Created by Рустем on 05.05.2022.
//

import UIKit

class PictureFromMarsTableViewCell: UITableViewCell {
    
    var api = ImageByUrlService()
    
    var picFromMarsLabel = UILabel()
    var picFromMarsImageView = UIImageView()
    var likeButton = UIButton()
    var index: IndexPath?
    var picFromMars: PictureFromMars?
    
    private var savePostsButtonDelegate: SavePostButtonDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        uiInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func uiInit() {
        contentView.addSubview(picFromMarsImageView)
        contentView.addSubview(picFromMarsLabel)
        contentView.addSubview(likeButton)
        
        let maxWidthContainer: CGFloat = 374
        let maxHeightContainer: CGFloat = 225
        picFromMarsImageView.layer.cornerRadius = 25
        picFromMarsImageView.clipsToBounds = true
        picFromMarsImageView.contentMode = .scaleAspectFill
        picFromMarsImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(45)
            make.width.equalTo(picFromMarsImageView.snp.height).multipliedBy(maxWidthContainer/maxHeightContainer)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        picFromMarsLabel.textColor = .white
        picFromMarsLabel.attributedText = NSAttributedString(string: "ФОТО С МАРСА", attributes: [.kern: 6])
        picFromMarsLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        picFromMarsLabel.snp.makeConstraints { make in
            make.top.equalTo(picFromMarsImageView).offset(8)
            make.centerX.equalToSuperview()
        }
        
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        likeButton.setTitleColor(UIColor.link, for: .normal)
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(picFromMarsImageView.snp_bottomMargin).offset(12)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func configure(delegate: SavePostButtonDelegate?, index: IndexPath?) {
        savePostsButtonDelegate = delegate
        self.index = index
        picFromMarsImageView.image = UIImage(named: "loading")
        api.getImageByUrl(url: picFromMars?.photos.first?.imgSrc ?? String()) { result in
            switch result {
            case .success(let image):
                self.picFromMarsImageView.image = image
            case .failure(let error):
                print(error)
            }
        }
        updateSaveButtonView()
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
        let saved = picFromMars?.isSaved ?? false
        picFromMars?.isSaved = !saved
        
        if (picFromMars?.isSaved ?? false) {
            savePostsButtonDelegate?.savePost(post: picFromMars!, index: index)
        } else {
            savePostsButtonDelegate?.removePostFromSaved(post: picFromMars!,index: index)
        }
        updateSaveButtonView()
    }
    
    func updateSaveButtonView() {
        if (picFromMars?.isSaved ?? false) {
            likeButton.setTitle(" Понравилось", for: .normal)
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else{
            likeButton.setTitle(" Нравится", for: .normal)
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
