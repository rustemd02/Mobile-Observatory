//
//  SpaceArchiveViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 12.05.2022.
//

import Foundation
import UIKit

protocol SpaceArchiveViewControllerInput: AnyObject {

}

protocol SpaceArchiveViewControllerOutput {
    

}

class SpaceArchiveViewController: UIViewController {
    private var output: SpaceArchiveViewControllerOutput
    var scrollView = UIScrollView()
    var contentView = UIView()
    var searchController = UISearchController()
    var spaceXImageView = UIImageView()
    var planetsImageView = UIImageView()
    var planetsLabel = UILabel()
    var asteroidsImageView = UIImageView()
    var asteroidsLabel = UILabel()
    
    init(output: SpaceArchiveViewControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Поиск по базе знаний"
        
        let spaceXTap = UITapGestureRecognizer(target: self, action: #selector(goToSpaceXScreen))
        spaceXImageView.isUserInteractionEnabled = true
        spaceXImageView.addGestureRecognizer(spaceXTap)
        
        let planetsTap = UITapGestureRecognizer(target: self, action: #selector(goToPlanetsScreen))
        planetsImageView.isUserInteractionEnabled = true
        planetsImageView.addGestureRecognizer(planetsTap)
    }
    
    func setupView() {
        title = "База знаний"
        view.backgroundColor = .white
        
        self.navigationItem.title = "База знаний"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.bottom.right.top.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.width.height.top.bottom.equalTo(self.scrollView)
        }
        
        contentView.addSubview(searchController.searchBar)
        contentView.addSubview(spaceXImageView)
        contentView.addSubview(planetsImageView)
        contentView.addSubview(planetsLabel)
        contentView.addSubview(asteroidsImageView)
        contentView.addSubview(asteroidsLabel)
        
        searchController.searchBar.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            
        }
        let maxWidthContainerBig: CGFloat = 374
        let maxHeightContainerBig: CGFloat = 225
        spaceXImageView.image = UIImage(named: "spacexlogo")
        spaceXImageView.layer.cornerRadius = 25
        spaceXImageView.clipsToBounds = true
        spaceXImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.width.equalTo(spaceXImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        planetsImageView.image = UIImage(named: "planets")
        planetsImageView.layer.cornerRadius = 25
        planetsImageView.clipsToBounds = true
        planetsImageView.contentMode = .scaleAspectFill
        let maxWidthContainerSmall: CGFloat = 150
        let maxHeightContainerSmall: CGFloat = 150
        planetsImageView.snp.makeConstraints { make in
            make.top.equalTo(spaceXImageView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(contentView.snp_centerXWithinMargins).offset(-4)
            make.width.equalTo(planetsImageView.snp.height).multipliedBy(maxWidthContainerSmall/maxHeightContainerSmall)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        planetsLabel.textColor = .white
        planetsLabel.text = "ПЛАНЕТЫ"
        planetsLabel.font = UIFont.systemFont(ofSize: 20, weight: .black)
        planetsLabel.snp.makeConstraints { make in
            make.left.equalTo(planetsImageView).offset(12)
            make.bottom.equalTo(planetsImageView).inset(12)
        }
        
        asteroidsImageView.image = UIImage(named: "asteroids")
        asteroidsImageView.layer.cornerRadius = 25
        asteroidsImageView.clipsToBounds = true
        asteroidsImageView.contentMode = .scaleAspectFill
        asteroidsImageView.snp.makeConstraints { make in
            make.top.equalTo(spaceXImageView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.snp_centerXWithinMargins).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.width.equalTo(asteroidsImageView.snp.height).multipliedBy(maxWidthContainerSmall/maxHeightContainerSmall)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        asteroidsLabel.textColor = .white
        asteroidsLabel.text = "АСТЕРОИДЫ"
        asteroidsLabel.font = UIFont.systemFont(ofSize: 20, weight: .black)
        asteroidsLabel.snp.makeConstraints { make in
            make.left.equalTo(asteroidsImageView).offset(12)
            make.bottom.equalTo(asteroidsImageView).inset(12)
        }
        
    }
    
    @objc func goToSpaceXScreen() {
        let vc: SpaceXViewController = SpaceXModuleBuilder().build()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToPlanetsScreen() {
        let vc: PlanetsViewController = PlanetsModuleBuilder().build()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SpaceArchiveViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
    }
    
    
}
