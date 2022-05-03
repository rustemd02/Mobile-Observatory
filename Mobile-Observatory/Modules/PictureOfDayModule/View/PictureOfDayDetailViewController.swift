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
    
    var picOfDay: PictureOfDay?
    
    var stringDate: String?
    var datePicker = UIDatePicker()
    
    var picOfDayImageView = UIImageView()
    var dateLabel = UILabel()
    var titleLabel = UILabel()
    var descriptionTextView = UITextView()
    var shareButton = UIButton(type: .roundedRect)
    var likeButton = UIButton(type: .roundedRect)
    

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
        view.addSubview(shareButton)
        view.addSubview(likeButton)
        
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
        
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
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
    }
    
    @objc func presentShareMenu() {
        guard let picOfDayImage = picOfDayImageView.image else {
            return
        }
        let shareMenuVC = UIActivityViewController(activityItems: [picOfDayImage], applicationActivities: nil )
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
            self.output.getPicOfDay(date: self.datePicker.date) { newPicOfDay in
                self.picOfDay = newPicOfDay
                self.configure()
            }
        }))
        present(alert, animated: true)
    }

}
