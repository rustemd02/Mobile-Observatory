//
//  SearchResultViewController.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 28.05.2022.
//

import Foundation
import UIKit

protocol SearchResultDetailInput: AnyObject {
}

protocol SearchResultDetailOutput {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
}

class SearchResultDetailViewController: UIViewController  {
    
    private var output: SearchResultDetailOutput
    
    var item: Item?
    var nasaIDLabel = UILabel()
    var sourceLabel = UILabel()
    var createdAtLabel = UILabel()
    var titleLabel = UILabel()
    var imageView = UIImageView()
    var descriptionTextView = UITextView()
    var shareButton = UIButton(type: .roundedRect)
    
    init(output: SearchResultDetailOutput) {
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
        view.addSubview(nasaIDLabel)
        view.addSubview(createdAtLabel)
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(descriptionTextView)
        view.addSubview(shareButton)
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp_bottomMargin).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        nasaIDLabel.snp.makeConstraints { make in
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
            make.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configure() {
        guard let item = item else { return }
        guard let datum = item.data.first else { return }
        self.sourceLabel.text = item.data.first?.photographer
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let stringDate = dateFormatter.string(from: datum.dateCreated)
        self.createdAtLabel.text = stringDate
        
        self.titleLabel.text = datum.title
        self.descriptionTextView.text = datum.datumDescription
        
        imageView.isHidden = true
        switch (datum.mediaType) {
        case .image:
            imageView.isHidden = false
            self.imageView.image = UIImage(named: "loading")
            output.getImage(url: item.links.first?.href ?? "") { loadedImage in
                self.imageView.image = loadedImage
            }
        case .audio: break
        case .video: break
        }
    }
    
    @objc func presentShareMenu() {
        guard let item = item, let itemUrl = URL(string: item.href) else {
            return
        }
        let shareMenuVC = UIActivityViewController(activityItems: [itemUrl], applicationActivities: nil)
        present(shareMenuVC, animated: true)
    }
}
