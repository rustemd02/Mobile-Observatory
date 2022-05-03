//
//  PictureOfDayTableViewCell.swift
//  Mobile-Observatory
//
//  Created by Рустем on 22.04.2022.
//

import UIKit

class PictureOfDayTableViewCell: UITableViewCell {
    
    var api = ImageByUrlService()
        
    
    var picOfDayImageView = UIImageView()
    var picOfDayLabel = UILabel()
    var likeButton = UIButton()

    
    var pictureOfDay: PictureOfDay?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        uiInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func uiInit() {

        contentView.addSubview(picOfDayImageView)
        contentView.addSubview(picOfDayLabel)
        contentView.addSubview(likeButton)

        picOfDayImageView.layer.cornerRadius = 25
        picOfDayImageView.clipsToBounds = true
        picOfDayImageView.contentMode = .scaleAspectFill
        picOfDayImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.right.bottom.equalToSuperview().inset(16)
            make.height.lessThanOrEqualTo(200)
        }
        
        picOfDayLabel.textColor = .white
        picOfDayLabel.attributedText = NSAttributedString(string: "ФОТО ДНЯ", attributes: [.kern: 6])
        picOfDayLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        picOfDayLabel.snp.makeConstraints { make in
            make.top.equalTo(picOfDayImageView).offset(8)
            make.centerX.equalToSuperview()
        }
        
        likeButton.isHidden = true
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(picOfDayImageView).inset(12)
            make.left.equalTo(picOfDayImageView).offset(12)
        }
        
    }
    
    func configure() {
        picOfDayImageView.image = UIImage(named: "loading")
        api.getImageByUrl(url: pictureOfDay?.imageUrl ?? String()) { result in
            switch result {
            case .success(let image):
                self.picOfDayImageView.image = image
            case .failure(let error):
                print(error)
            }
        }
        updateSaveButtonView()

    }

    
    func updateSaveButtonView() {
        if (pictureOfDay?.isSaved ?? false) {
            likeButton.setTitle(" Понравилось", for: .normal)
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else{
            likeButton.setTitle(" Нравится", for: .normal)
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
