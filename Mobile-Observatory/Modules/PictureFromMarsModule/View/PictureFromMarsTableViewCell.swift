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
    
    var picFromMars: PictureFromMars?
    
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
        
        picFromMarsImageView.layer.cornerRadius = 25
        picFromMarsImageView.clipsToBounds = true
        picFromMarsImageView.contentMode = .scaleAspectFill
        picFromMarsImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.right.bottom.equalToSuperview().inset(16)
            make.height.lessThanOrEqualTo(200)
        }
        
        picFromMarsLabel.textColor = .white
        picFromMarsLabel.attributedText = NSAttributedString(string: "ФОТО С МАРСА", attributes: [.kern: 6])
        picFromMarsLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        picFromMarsLabel.snp.makeConstraints { make in
            make.top.equalTo(picFromMarsImageView).offset(8)
            make.centerX.equalToSuperview()
        }
        
        likeButton.isHidden = true
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(picFromMarsImageView).inset(12)
            make.left.equalTo(picFromMarsImageView).offset(12)
        }
    }
    
    func configure() {
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
