//
//  ArticleDetailViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 28.03.2022.
//

import UIKit
import SnapKit

protocol ArticleDetailViewControllerInput: AnyObject {
    
}

protocol ArticleDetailViewControllerOutput {
    
}

class ArticleDetailViewController: UIViewController {
    
    private var output: ArticleDetailViewControllerOutput
    
    var article: Article?
    var sourceLabel = UILabel()
    var createdAtLabel = UILabel()
    var titleLabel = UILabel()
    var imageView = UIImageView()
    var descriptionTextView = UITextView()
    
    init(output: ArticleDetailViewControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiInit()
        configure()
    }
    
    private func uiInit () {
        view.addSubview(sourceLabel)
        view.addSubview(createdAtLabel)
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(descriptionTextView)
        
        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-40)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(8)
        }
        
        createdAtLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        createdAtLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-40)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(sourceLabel.safeAreaLayoutGuide).offset(-20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
        let maxWidthContainer: CGFloat = 374
        let maxHeightContainer: CGFloat = 225
        imageView.layer.cornerRadius = 10
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(12)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.width.equalTo(imageView.snp.height).multipliedBy(maxWidthContainer/maxHeightContainer)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        descriptionTextView.isEditable = false
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp_bottomMargin)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configure() {
        guard let article = article else {
            return
        }
        self.sourceLabel.text = article.newsSite
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let stringDate = dateFormatter.string(from: article.createdAt)
        self.createdAtLabel.text = stringDate
        
        self.titleLabel.text = article.title
        self.descriptionTextView.text = article.summary
        self.imageView.image = UIImage(named: "loading")
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
