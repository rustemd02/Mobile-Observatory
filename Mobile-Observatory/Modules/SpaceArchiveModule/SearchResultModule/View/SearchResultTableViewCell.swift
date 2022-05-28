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
        
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.right.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    func configure() {
        self.titleLabel.text = item?.data.first?.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
