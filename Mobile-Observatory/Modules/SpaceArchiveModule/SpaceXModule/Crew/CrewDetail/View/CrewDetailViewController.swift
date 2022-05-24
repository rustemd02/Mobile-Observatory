//
//  CrewDetailViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 23.05.2022.
//

import UIKit
import SnapKit

protocol CrewDetailViewControllerInput: AnyObject {
    
}

protocol CrewDetailViewControllerOutput {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
}

class CrewDetailViewController: UIViewController {
    
    private var output: CrewDetailViewControllerOutput
    
    var crewMember: CrewMember?
    
    
    var nameLabel = UILabel()
    var imageView = UIImageView()
    
    var agencyView = UIView()
    var agencyLabel = UILabel()
    var agencyValue = UILabel()
    
    var wikiLinkView = UIView()
    var wikiLinkButton = UIButton()
    
    
    
    init(output: CrewDetailViewControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = "Сrew"
        uiInit()
        configure()
    }
    
    private func uiInit () {
        view.backgroundColor = .white
        navigationItem.title = crewMember?.name
        view.addSubview(nameLabel)
        view.addSubview(imageView)
        view.addSubview(agencyView)
        agencyView.addSubview(agencyLabel)
        agencyView.addSubview(agencyValue)
        view.addSubview(wikiLinkView)
        wikiLinkView.addSubview(wikiLinkButton)
        
        let maxWidthContainer: CGFloat = 100
        let maxHeightContainer: CGFloat = 150
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(64)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(64)
            make.width.equalTo(imageView.snp.height).multipliedBy(maxWidthContainer/maxHeightContainer)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        agencyView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        agencyView.layer.cornerRadius = 12
        agencyView.clipsToBounds = true
        agencyView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp_bottomMargin).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(64)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(64)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        agencyLabel.textColor = .black
        agencyLabel.attributedText = NSAttributedString(string: "агентство", attributes: [.kern: 6])
        agencyLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        agencyLabel.snp.makeConstraints { make in
            make.top.equalTo(agencyView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        agencyValue.textColor = .black
        agencyValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        agencyValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(agencyLabel).offset(-14)
        }
        
        wikiLinkView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        wikiLinkView.layer.cornerRadius = 12
        wikiLinkView.clipsToBounds = true
        wikiLinkView.snp.makeConstraints { make in
            make.top.equalTo(agencyView.snp_bottomMargin).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(64)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(64)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
        }
        
        wikiLinkButton.setTitle("подробнее на википедии", for: .normal)
        wikiLinkButton.setTitleColor(.link, for: .normal)
        wikiLinkButton.addTarget(self, action: #selector(openInSafari), for: .touchUpInside)
        wikiLinkButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(wikiLinkView)
        }
        
    }
    
    
    func configure() {
        guard let crewMember = crewMember else {
            return
        }
        nameLabel.text = crewMember.name
        agencyValue.text = crewMember.agency
        output.getImage(url: crewMember.image) { image in
            self.imageView.image = image
        }
        
        
    }
    
    @objc func openInSafari() {
        guard let crewMember = crewMember else {
            return
        }

        guard let url = URL(string: crewMember.wikipedia) else { return }
        UIApplication.shared.open(url)
    }
}




