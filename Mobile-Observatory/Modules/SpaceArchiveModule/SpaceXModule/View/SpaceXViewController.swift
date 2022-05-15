//
//  SpaceXViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 12.05.2022.
//

import UIKit

protocol SpaceXViewControllerInput: AnyObject {

}

protocol SpaceXViewControllerOutput {
    

}

class SpaceXViewController: UIViewController {
    private var output: SpaceXViewControllerOutput
    
    var contentView = UIView()
    var scrollView = UIScrollView()
    var spaceXImageView = UIImageView()
    
    var launchesImageView = UIImageView()
    var launchesLabel = UILabel()
    
    var crewMembersImageView = UIImageView()
    var crewMembersLabel = UILabel()
    
    var rocketsImageView = UIImageView()
    var rocketsLabel = UILabel()
    
    
    init(output: SpaceXViewControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SpaceX"
        uiInit()
    }
    
    func uiInit() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.bottom.right.top.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.width.height.top.bottom.equalTo(self.scrollView)
        }
        
        contentView.addSubview(spaceXImageView)
        contentView.addSubview(launchesImageView)
        contentView.addSubview(launchesLabel)
        contentView.addSubview(crewMembersImageView)
        contentView.addSubview(crewMembersLabel)
        contentView.addSubview(rocketsImageView)
        contentView.addSubview(rocketsLabel)
        
        let maxWidthContainerBig: CGFloat = 374
        let maxHeightContainerBig: CGFloat = 225
        spaceXImageView.image = UIImage(named: "spacexlogo")
        spaceXImageView.layer.cornerRadius = 25
        spaceXImageView.clipsToBounds = true
        spaceXImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.width.equalTo(spaceXImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        launchesImageView.image = UIImage(named: "launches")
        launchesImageView.layer.cornerRadius = 25
        launchesImageView.clipsToBounds = true
        launchesImageView.snp.makeConstraints { make in
            make.top.equalTo(spaceXImageView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.width.equalTo(launchesImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        launchesLabel.textColor = .white
        launchesLabel.text = "ЗАПУСКИ"
        launchesLabel.font = UIFont.systemFont(ofSize: 32, weight: .black)
        launchesLabel.snp.makeConstraints { make in
            make.left.equalTo(launchesImageView).offset(12)
            make.bottom.equalTo(launchesImageView).inset(12)
        }
        
        crewMembersImageView.image = UIImage(named: "crewmembers")
        crewMembersImageView.layer.cornerRadius = 25
        crewMembersImageView.clipsToBounds = true
        crewMembersImageView.snp.makeConstraints { make in
            make.top.equalTo(launchesImageView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.width.equalTo(crewMembersImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        crewMembersLabel.textColor = .white
        crewMembersLabel.text = "CREW DRAGON"
        crewMembersLabel.font = UIFont.systemFont(ofSize: 32, weight: .black)
        crewMembersLabel.snp.makeConstraints { make in
            make.left.equalTo(crewMembersImageView).offset(12)
            make.bottom.equalTo(crewMembersImageView).inset(12)
        }
        
        rocketsImageView.image = UIImage(named: "rockets")
        rocketsImageView.layer.cornerRadius = 25
        rocketsImageView.clipsToBounds = true
        rocketsImageView.snp.makeConstraints { make in
            make.top.equalTo(crewMembersImageView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.width.equalTo(rocketsImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        rocketsLabel.textColor = .white
        rocketsLabel.text = "РАКЕТЫ"
        rocketsLabel.font = UIFont.systemFont(ofSize: 32, weight: .black)
        rocketsLabel.snp.makeConstraints { make in
            make.left.equalTo(rocketsImageView).offset(12)
            make.bottom.equalTo(rocketsImageView).inset(12)
        }
    }
   

}
