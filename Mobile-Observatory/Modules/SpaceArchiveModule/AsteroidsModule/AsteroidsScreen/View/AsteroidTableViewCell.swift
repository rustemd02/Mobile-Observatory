//
//  AsteroidTableViewCell.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 31.05.2022.
//

import Foundation
import UIKit

class AsteroidTableViewCell: UITableViewCell {
    
    var asteroid: NearEarthObject?
    
    var asteroidImageView = UIImageView()
    private var nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        uiInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func uiInit() {
        contentView.addSubview(asteroidImageView)
        contentView.addSubview(nameLabel)
        
        let maxWidthContainerBig: CGFloat = 374
        let maxHeightContainerBig: CGFloat = 225
        asteroidImageView.layer.cornerRadius = 25
        asteroidImageView.clipsToBounds = true
        asteroidImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.width.equalTo(asteroidImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.width.height.equalTo(contentView.safeAreaLayoutGuide).priority(.high)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(asteroidImageView)
            make.centerY.equalTo(asteroidImageView)
        }
    }
    
    func configure() {
        guard let asteroid = self.asteroid else { return }
        nameLabel.attributedText = NSAttributedString(string: asteroid.name, attributes: [.kern: 6])
        asteroidImageView.image = asteroid.image
    }
}
