//
//  ArticleDetailViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 28.03.2022.
//

import UIKit
import SnapKit

class ArticleDetailViewController: UIViewController {
    
    var article: Article?
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
//    var siteLabel = UILabel()
//    var dateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //uiInit()
        configure()
    }
    
//    private func uiInit () {
//
//        view.addSubview(siteLabel)
//        view.addSubview(dateLabel)
//
//        siteLabel.snp.makeConstraints { make in
//            make.top.left.equalToSuperview().inset(8)
//        }
//        dateLabel.snp.makeConstraints { make in
//            make.top.right.equalToSuperview().inset(8)
//        }
//
//    }
    
    func configure() {
        guard let article = article else {
            return
        }
        
        //siteLabel.text = "fdsfds"
        
        self.sourceLabel.text = article.newsSite
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let stringDate = dateFormatter.string(from: article.createdAt)
        self.createdAtLabel.text = stringDate
        
        self.titleLabel.text = article.title
        self.descriptionTextView.text = article.summary
        self.imageView.image = nil
        NetworkService.shared.getImageByUrl(url: article.pictureUrl, completion: { result in
            switch result {
            case .success(let image):
                self.imageView.image = image
            case .failure(let error):
                print(error)
            }
        
        })
    }
    
}
