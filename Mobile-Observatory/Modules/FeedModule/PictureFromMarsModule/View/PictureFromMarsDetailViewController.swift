//
//  PictureFromMarsDetailViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 05.05.2022.
//

import Foundation
import UIKit

protocol PictureFromMarsDetailViewControllerInput: AnyObject {
    
}

protocol PictureFromMarsDetailViewControllerOutput {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
    func getPicFromMars(date: Date, completion: @escaping (PictureFromMars) -> Void)
}

class PictureFromMarsDetailViewController: UIViewController {
    private var output: PictureFromMarsDetailViewControllerOutput
    var saveButtonDelegate: SavePostButtonDelegate?
    
    var picFromMars: PictureFromMars?
    private var dateLabel = UILabel()
    private var imageView = UIImageView()
    private var shotOnLabel = UILabel()
    private var roverLabel = UILabel()
    
    private var stringDate: String?
    private var datePicker = UIDatePicker()
    
    private var shareButton = UIButton(type: .roundedRect)
    private var likeButton = UIButton(type: .roundedRect)
    var index: IndexPath?
    
    init(output: PictureFromMarsDetailViewControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "calendar.circle"), style: .plain, target: self, action: #selector(changeDate))
        datePicker.datePickerMode = .date
        uiInit()
        configure()
    }
    
    func uiInit() {
        view.addSubview(imageView)
        view.addSubview(dateLabel)
        view.addSubview(shareButton)
        view.addSubview(likeButton)
        view.addSubview(shotOnLabel)
        view.addSubview(roverLabel)
        view.backgroundColor = .white
        
        let maxWidthContainer: CGFloat = 374
        let maxHeightContainer: CGFloat = 225
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(view.safeAreaLayoutGuide).offset(-90)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.width.equalTo(imageView.snp.height).multipliedBy(maxWidthContainer/maxHeightContainer)
            make.width.height.equalToSuperview().priority(.high)
        }
        
    
        dateLabel.textColor = .black
        dateLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView).offset(-30)
            make.centerX.equalToSuperview()
        }
        
        shotOnLabel.textColor = .black
        shotOnLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        shotOnLabel.text = "Снято на "
        shotOnLabel.snp.makeConstraints { make in
            make.bottom.equalTo(imageView).offset(30)
            make.right.equalTo(roverLabel.snp_leftMargin).inset(-8)
        }
        
        roverLabel.textColor = .black
        roverLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        roverLabel.snp.makeConstraints { make in
            make.bottom.equalTo(imageView).offset(30)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.setTitle(" Поделиться", for: .normal)
        shareButton.setTitleColor(.link, for: .normal)
        shareButton.addTarget(self, action: #selector(presentShareMenu), for: .touchUpInside)
        shareButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setTitle(" Нравится", for: .normal)
        likeButton.setTitleColor(.link, for: .normal)
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
        updateSaveButtonView()
    }
    
    func configure() {
        guard let picFromMars = picFromMars else {
            return
        }
        if (picFromMars.photos.isEmpty) {
            return
        }
        imageView.image = UIImage(named: "loading")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        stringDate = dateFormatter.string(from: picFromMars.photos[0].earthDate)
        dateLabel.attributedText = NSAttributedString(string: "ФОТО " + (stringDate ?? "ДНЯ"), attributes: [.kern: 10])
        roverLabel.text = picFromMars.photos[0].rover.name
        output.getImage(url: picFromMars.photos[0].imgSrc) { image in
            self.imageView.image = image
        }
    }
    
    @objc func presentShareMenu() {
        guard let picFromMarsImage = imageView.image else {
            return
        }
        let shareMenuVC = UIActivityViewController(activityItems: [picFromMarsImage], applicationActivities: nil )
        present(shareMenuVC, animated: true)
    }
    
    @objc func changeDate() {
        
        let alert = UIAlertController(title: "Выберите дату", message: " ", preferredStyle: .alert)
        alert.view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(alert.view)
        }
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Применить", style: .default, handler: { _ in
            self.output.getPicFromMars(date: self.datePicker.date) { newPicFromMars in
                self.picFromMars = newPicFromMars
                self.configure()
                self.updateSaveButtonView()
            }
        }))
        present(alert, animated: true)
    }
    
    func updateSaveButtonView() {
        if (picFromMars?.isSaved ?? false) {
            likeButton.setTitle("Понравилось", for: .normal)
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else{
            likeButton.setTitle("Нравится", for: .normal)
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        let saved = picFromMars?.isSaved ?? false
        picFromMars?.isSaved = !saved
        
        if (picFromMars?.isSaved ?? false) {
            saveButtonDelegate?.savePost(post: picFromMars!, index: index)
        } else {
            saveButtonDelegate?.removePostFromSaved(post: picFromMars!, index: index)
        }
        updateSaveButtonView()
    }
}
