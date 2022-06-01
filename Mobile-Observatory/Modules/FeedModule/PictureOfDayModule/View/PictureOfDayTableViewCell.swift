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
    var index: IndexPath?
    var pictureOfDay: PictureOfDay?
    
    private var savePostsButtonDelegate: SavePostButtonDelegate?
    
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
        
        let maxWidthContainer: CGFloat = 374
        let maxHeightContainer: CGFloat = 225
        picOfDayImageView.layer.cornerRadius = 25
        picOfDayImageView.clipsToBounds = true
        picOfDayImageView.contentMode = .scaleAspectFill
        picOfDayImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(45)
            make.width.equalTo(picOfDayImageView.snp.height).multipliedBy(maxWidthContainer/maxHeightContainer)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        picOfDayLabel.textColor = .white
        picOfDayLabel.attributedText = NSAttributedString(string: "ФОТО ДНЯ", attributes: [.kern: 6])
        picOfDayLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        picOfDayLabel.snp.makeConstraints { make in
            make.top.equalTo(picOfDayImageView).offset(8)
            make.centerX.equalToSuperview()
        }
        
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        likeButton.setTitleColor(UIColor.link, for: .normal)
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(picOfDayImageView.snp_bottomMargin).offset(12)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        
    }
    
    func configure(delegate: SavePostButtonDelegate?, index: IndexPath?) {
        savePostsButtonDelegate = delegate
        self.index = index
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
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
        let saved = pictureOfDay?.isSaved ?? false
        pictureOfDay?.isSaved = !saved
        
        if (pictureOfDay?.isSaved ?? false) {
            savePostsButtonDelegate?.savePost(post: pictureOfDay!, index: index)
        } else {
            savePostsButtonDelegate?.removePostFromSaved(post: pictureOfDay!, index: index)
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
