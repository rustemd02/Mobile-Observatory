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
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
}

class ArticleDetailViewController: UIViewController {
    
    private var output: ArticleDetailViewControllerOutput
    var saveButtonDelegate: SavePostButtonDelegate?
    
    var article: Article?
    
    var sourceLabel = UILabel()
    var createdAtLabel = UILabel()
    var titleLabel = UILabel()
    var imageView = UIImageView()
    var descriptionTextView = UITextView()
    var shareButton = UIButton(type: .roundedRect)
    var likeButton = UIButton(type: .roundedRect)
    var index: IndexPath?
    
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
        view.addSubview(shareButton)
        view.addSubview(likeButton)
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp_bottomMargin).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        createdAtLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        createdAtLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp_bottomMargin).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(sourceLabel.safeAreaLayoutGuide).offset(30)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        let maxWidthContainer: CGFloat = 374
        let maxHeightContainer: CGFloat = 225
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(imageView.snp.height).multipliedBy(maxWidthContainer/maxHeightContainer)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        descriptionTextView.isEditable = false
        descriptionTextView.font = UIFont.systemFont(ofSize: 18)
        descriptionTextView.textColor = .black
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(12)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.bottom.equalTo(shareButton.safeAreaLayoutGuide).inset(32)
        }
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.setTitle(" Поделиться", for: .normal)
        shareButton.setTitleColor(.link, for: .normal)
        shareButton.addTarget(self, action: #selector(presentShareMenu), for: .touchUpInside)
        shareButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setTitle(" Нравится", for: .normal)
        likeButton.setTitleColor(.link, for: .normal)
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(24)
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
        output.getImage(url: article.pictureUrl) { loadedImage in
            self.imageView.image = loadedImage
        }
        
        updateSaveButtonView()
    }
    
    func updateSaveButtonView() {
        if (article?.isSaved ?? false) {
            likeButton.setTitle("Понравилось", for: .normal)
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else{
            likeButton.setTitle("Нравится", for: .normal)
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        let saved = article?.isSaved ?? false
        article?.isSaved = !saved
        
        if (article?.isSaved ?? false) {
            saveButtonDelegate?.savePost(post: article!, index: index)
        } else {
            saveButtonDelegate?.removePostFromSaved(post: article!, index: index)
        }
        updateSaveButtonView()
    }
    
    @objc func presentShareMenu() {
        guard let article = article, let articleUrl = URL(string: article.articleUrl) else {
            return
        }
        let shareMenuVC = UIActivityViewController(activityItems: [articleUrl], applicationActivities: nil )
        present(shareMenuVC, animated: true)
    }
    
}
