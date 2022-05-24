//
//  RocketTableViewCell.swift
//  Mobile-Observatory
//
//  Created by Рустем on 24.05.2022.
//

import UIKit

class RocketTableViewCell: UITableViewCell {
    
    var api = ImageByUrlService()
        
    var rocketImageView = UIImageView()
    var rocketNameLabel = UILabel()

    var rocket: Rocket?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        uiInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func uiInit() {

        contentView.addSubview(rocketImageView)
        contentView.addSubview(rocketNameLabel)

        let maxWidthContainer: CGFloat = 374
        let maxHeightContainer: CGFloat = 225
        rocketImageView.layer.cornerRadius = 25
        rocketImageView.clipsToBounds = true
        rocketImageView.contentMode = .scaleAspectFill
        rocketImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.right.bottom.equalToSuperview().inset(16)
            make.width.equalTo(rocketImageView.snp.height).multipliedBy(maxWidthContainer/maxHeightContainer)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        rocketNameLabel.textColor = .white
        rocketNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        rocketNameLabel.snp.makeConstraints { make in
            make.top.equalTo(rocketImageView).offset(8)
            make.centerX.equalToSuperview()
        }
        
    }
    
    func configure() {
        rocketNameLabel.attributedText = NSAttributedString(string: rocket?.name ?? "РАКЕТА", attributes: [.kern: 6])
        rocketImageView.image = UIImage(named: "loading")
        api.getImageByUrl(url: rocket?.flickrImages.first ?? String()) { result in
            switch result {
            case .success(let image):
                self.rocketImageView.image = image
            case .failure(let error):
                print(error)
            }
        }

    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
