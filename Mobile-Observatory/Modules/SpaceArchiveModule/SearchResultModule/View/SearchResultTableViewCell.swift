//
//  SearchResultTableViewCell.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 28.05.2022.
//

import Foundation
import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var mediaTypeLabel = UILabel()
    var item: Item?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        uiInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func uiInit() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(mediaTypeLabel)
        
        mediaTypeLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        mediaTypeLabel.numberOfLines = 0
        mediaTypeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.right.equalTo(mediaTypeLabel).inset(60)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    func configure() {
        self.titleLabel.text = item?.data.first?.title
        self.mediaTypeLabel.text = item?.data.first?.mediaType.rawValue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
