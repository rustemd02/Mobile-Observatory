//
//  PictureOfDayViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 22.04.2022.
//

import UIKit

protocol PictureOfDayDetailViewControllerInput: AnyObject {
    
}

protocol PictureOfDayDetailViewControllerOutput {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
    func getPicOfDay(date: Date, completion: @escaping (PictureOfDay) -> Void)
}

class PictureOfDayDetailViewController: UIViewController {
    private var output: PictureOfDayDetailViewControllerOutput
    var saveButtonDelegate: SavePostButtonDelegate?
    
    var picOfDay: PictureOfDay?
    
    var stringDate: String?
    var datePicker = UIDatePicker()
    
    var picOfDayImageView = UIImageView()
    var dateLabel = UILabel()
    var titleLabel = UILabel()
    var descriptionTextView = UITextView()
    var shareView = UIView()
    var likeView = UIView()
    var shareButton = UIButton(type: .roundedRect)
    var likeButton = UIButton(type: .roundedRect)
    
    let likeColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    let likeBackgroundColor = #colorLiteral(red: 0.8539047241, green: 0.8987153172, blue: 0.8979462981, alpha: 1)
    var index: IndexPath?

    init(output: PictureOfDayDetailViewControllerOutput) {
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
        view.addSubview(picOfDayImageView)
        view.addSubview(dateLabel)
        view.addSubview(titleLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(likeView)
        view.addSubview(shareView)
        
        shareView.addSubview(shareButton)
        likeView.addSubview(likeButton)
        
        view.backgroundColor = .white
                
        let maxWidthContainer: CGFloat = 374
        let maxHeightContainer: CGFloat = 225
        picOfDayImageView.layer.cornerRadius = 25
        picOfDayImageView.clipsToBounds = true
        picOfDayImageView.contentMode = .scaleAspectFill
        picOfDayImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(-50)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.width.equalTo(picOfDayImageView.snp.height).multipliedBy(maxWidthContainer/maxHeightContainer)
            make.width.height.equalToSuperview().priority(.high)
        }
        
    
        dateLabel.textColor = .white
        dateLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(picOfDayImageView).offset(20)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(picOfDayImageView.snp_bottomMargin).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
        
        descriptionTextView.isEditable = false
        descriptionTextView.font = UIFont.systemFont(ofSize: 18)
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(8)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.bottom.equalTo(shareButton.safeAreaLayoutGuide).inset(32)
        }
        
        shareView.backgroundColor = likeBackgroundColor
        shareView.layer.cornerRadius = 13
        shareView.clipsToBounds = true
        shareView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(32)
        }
        
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up")?.withTintColor(likeColor, renderingMode: .alwaysOriginal), for: .normal)
        shareButton.setTitle("Поделиться", for: .normal)
        shareButton.setTitleColor(likeColor, for: .normal)
        shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        shareButton.addTarget(self, action: #selector(presentShareMenu), for: .touchUpInside)
        shareButton.imageView?.contentMode = .scaleAspectFit
        shareButton.snp.makeConstraints { make in
            make.top.left.equalTo(shareView).offset(8)
            make.bottom.right.equalTo(shareView).inset(8)
        }
        
        likeView.backgroundColor = likeBackgroundColor
        likeView.layer.cornerRadius = 13
        likeView.clipsToBounds = true
        likeView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.height.equalTo(32)
        }
        
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        likeButton.setTitleColor(likeColor, for: .normal)
        likeButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        likeButton.snp.makeConstraints { make in
            make.top.left.equalTo(likeView).offset(8)
            make.bottom.right.equalTo(likeView).inset(8)
        }
        updateSaveButtonView()
    }
    
    func configure() {
        guard let picOfDay = picOfDay else {
            return
        }

        titleLabel.text = picOfDay.title
        picOfDayImageView.image = UIImage(named: "loading")
        output.getImage(url: picOfDay.imageUrl) { image in
            self.picOfDayImageView.image = image
        }
        descriptionTextView.text = picOfDay.description
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        stringDate = dateFormatter.string(from: picOfDay.date)
        dateLabel.attributedText = NSAttributedString(string: "ФОТО " + (stringDate ?? "ДНЯ"), attributes: [.kern: 10])
        updateSaveButtonView()
    }
    
    @objc func presentShareMenu() {
        guard let picOfDayImage = picOfDayImageView.image else {
            return
        }
        let shareMenuVC = UIActivityViewController(activityItems: [picOfDayImage], applicationActivities: nil )
        present(shareMenuVC, animated: true)
    }
    
    @objc func changeDate() {
        guard let picOfDay = picOfDay else {
            return
        }

        datePicker.date = picOfDay.date
        
        let alert = UIAlertController(title: "Выберите дату", message: " ", preferredStyle: .alert)
        alert.view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(alert.view)
        }
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Применить", style: .default, handler: { _ in
            self.output.getPicOfDay(date: self.datePicker.date) { newPicOfDay in
                self.picOfDay = newPicOfDay
                self.configure()
                self.updateSaveButtonView()
            }
        }))
        present(alert, animated: true)
    }
    
    func updateSaveButtonView() {
        let likedImage = UIImage(systemName: "heart.fill")?.withTintColor(likeColor, renderingMode: .alwaysOriginal)
        let unlikedImage = UIImage(systemName: "heart")?.withTintColor(likeColor, renderingMode: .alwaysOriginal)
        if (picOfDay?.isSaved ?? false) {
            likeButton.setTitle("Понравилось", for: .normal)
            likeButton.setImage(likedImage, for: .normal)
        } else {
            likeButton.setTitle("Нравится", for: .normal)
            likeButton.setImage(unlikedImage, for: .normal)
        }
        likeButton.imageView?.contentMode = .scaleAspectFit
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        let saved = picOfDay?.isSaved ?? false
        picOfDay?.isSaved = !saved
        
        if (picOfDay?.isSaved ?? false) {
            saveButtonDelegate?.savePost(post: picOfDay!, index: index)
        } else {
            saveButtonDelegate?.removePostFromSaved(post: picOfDay!, index: index)
        }
        updateSaveButtonView()
    }
}
