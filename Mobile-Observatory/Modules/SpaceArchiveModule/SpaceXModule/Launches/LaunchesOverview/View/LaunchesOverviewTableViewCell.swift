//
//  LaunchesOverviewTableViewCell.swift
//  Mobile-Observatory
//
//  Created by Рустем on 03.06.2022.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {
    
    var api = ImageByUrlService()
    
    var launch: Launch?
    var name = UILabel()
    var date = UILabel()
    var photo = UIImageView()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        uiInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func uiInit() {
        contentView.addSubview(name)
        contentView.addSubview(photo)
        contentView.addSubview(date)
        
        photo.contentMode = .scaleAspectFill
        photo.layer.cornerRadius = 15
        photo.clipsToBounds = true
        photo.snp.makeConstraints { make in
            make.left.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.height.width.equalTo(50)
        }
        
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        name.snp.makeConstraints { make in
            make.left.equalTo(photo.snp.right).offset(16)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            
        }
        
        date.textColor = .lightGray
        date.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        date.snp.makeConstraints { make in
            make.top.equalTo(name.snp_bottomMargin).offset(8)
            make.left.equalTo(photo.snp.right).offset(16)
        }

    }
    
    func configure() {
        guard let launch = launch else {
            return
        }
        name.text = launch.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let stringDate = dateFormatter.string(from: launch.dateLocal)
        date.text = stringDate
        api.getImageByUrl(url: launch.links.patch?.large ?? "") { result in
            switch result {
            case .success(let image):
                self.photo.image = image
            case .failure(let error):
                self.photo.image = UIImage(named: "earth")
            }
        }
        
    }

}

