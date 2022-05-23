//
//  CrewMemberTableViewCell.swift
//  Mobile-Observatory
//
//  Created by Рустем on 23.05.2022.
//

import UIKit

class CrewMemberTableViewCell: UITableViewCell {
    
    var api = ImageByUrlService()
    
    var crewMember: CrewMember?
    var name = UILabel()
    var photo = UIImageView()
    var agency = UILabel()


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
        contentView.addSubview(agency)
        
        photo.contentMode = .scaleAspectFill
        photo.layer.cornerRadius = 25
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
        
        agency.textColor = .lightGray
        agency.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        agency.snp.makeConstraints { make in
            make.right.equalTo(contentView.safeAreaLayoutGuide).offset(-12)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    func configure() {
        guard let crewMember = crewMember else {
            return
        }
        agency.text = "из " + crewMember.agency
        name.text = crewMember.name
        api.getImageByUrl(url: crewMember.image ) { result in
            switch result {
            case .success(let image):
                self.photo.image = image
            case .failure(let error):
                print(error)
            }
        }
        
    }

}
