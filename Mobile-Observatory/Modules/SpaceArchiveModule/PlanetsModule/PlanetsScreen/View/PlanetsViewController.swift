//
//  PlanetsViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 13.05.2022.
//

import UIKit

protocol PlanetsViewControllerInput: AnyObject {

}

protocol PlanetsViewControllerOutput {
    

}

class PlanetsViewController: UIViewController {

    private var output: PlanetsViewControllerOutput
    var contentView = UIView()
    var scrollView = UIScrollView()
    
    var planetsImageView = UIImageView()
    
    var mercuryImageView = UIImageView()
    var mercuryLabel = UILabel()
    
    var venusImageView = UIImageView()
    var venusLabel = UILabel()
    
    var earthImageView = UIImageView()
    var earthLabel = UILabel()
    
    var marsImageView = UIImageView()
    var marsLabel = UILabel()
    
    var jupiterImageView = UIImageView()
    var jupiterLabel = UILabel()
    
    var saturnImageView = UIImageView()
    var saturnLabel = UILabel()
    
    var uranusImageView = UIImageView()
    var uranusLabel = UILabel()
    
    var neptuneImageView = UIImageView()
    var neptuneLabel = UILabel()
    
    var plutoImageView = UIImageView()
    var plutoLabel = UILabel()
    
    init(output: PlanetsViewControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Планеты"
        uiInit()
        
        let mercuryTap = UITapGestureRecognizer(target: self, action: #selector(goToMercuryDetailScreen))
        mercuryImageView.isUserInteractionEnabled = true
        mercuryImageView.addGestureRecognizer(mercuryTap)
        
//        let venusTap = UITapGestureRecognizer(target: self, action: #selector(goToVenusDetailScreen))
//        venusImageView.isUserInteractionEnabled = true
//        venusImageView.addGestureRecognizer(venusTap)
//
//        let marsTap = UITapGestureRecognizer(target: self, action: #selector(goToMarsDetailScreen))
//        marsImageView.isUserInteractionEnabled = true
//        marsImageView.addGestureRecognizer(marsTap)
        
    }
    
    @objc func goToMercuryDetailScreen() {
        let vc: PlanetDetailViewController = PlanetDetailModuleBuilder().build()
        vc.planetType = .mercury
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func uiInit() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(self.view)
        }
                
        contentView.addSubview(planetsImageView)
        
        contentView.addSubview(mercuryImageView)
        contentView.addSubview(mercuryLabel)
        
        contentView.addSubview(venusImageView)
        contentView.addSubview(venusLabel)
        
        contentView.addSubview(earthImageView)
        contentView.addSubview(earthLabel)
        
        contentView.addSubview(marsImageView)
        contentView.addSubview(marsLabel)
        
        contentView.addSubview(jupiterImageView)
        contentView.addSubview(jupiterLabel)
        
        contentView.addSubview(saturnImageView)
        contentView.addSubview(saturnLabel)
        
        contentView.addSubview(uranusImageView)
        contentView.addSubview(uranusLabel)
        
        contentView.addSubview(neptuneImageView)
        contentView.addSubview(neptuneLabel)
        
        contentView.addSubview(plutoImageView)
        contentView.addSubview(plutoLabel)
        
        let maxWidthContainerBig: CGFloat = 374
        let maxHeightContainerBig: CGFloat = 225
        planetsImageView.image = UIImage(named: "planets")
        planetsImageView.layer.cornerRadius = 25
        planetsImageView.clipsToBounds = true
        planetsImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.width.equalTo(planetsImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        mercuryImageView.image = UIImage(named: "mercury")
        mercuryImageView.layer.cornerRadius = 25
        mercuryImageView.clipsToBounds = true
        mercuryImageView.snp.makeConstraints { make in
            make.top.equalTo(planetsImageView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.width.equalTo(mercuryImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.height.equalTo(maxHeightContainerBig)
        }
        
        mercuryLabel.textColor = .white
        mercuryLabel.text = "МЕРКУРИЙ"
        mercuryLabel.font = UIFont.systemFont(ofSize: 32, weight: .black)
        mercuryLabel.snp.makeConstraints { make in
            make.left.equalTo(mercuryImageView).offset(12)
            make.bottom.equalTo(mercuryImageView).inset(12)
        }
        
        venusImageView.image = UIImage(named: "venus")
        venusImageView.layer.cornerRadius = 25
        venusImageView.clipsToBounds = true
        venusImageView.snp.makeConstraints { make in
            make.top.equalTo(mercuryImageView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.width.equalTo(venusImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.height.equalTo(maxHeightContainerBig)
        }
        
        venusLabel.textColor = .white
        venusLabel.text = "ВЕНЕРА"
        venusLabel.font = UIFont.systemFont(ofSize: 32, weight: .black)
        venusLabel.snp.makeConstraints { make in
            make.left.equalTo(venusImageView).offset(12)
            make.bottom.equalTo(venusImageView).inset(12)
        }
        
        earthImageView.image = UIImage(named: "earth")
        earthImageView.layer.cornerRadius = 25
        earthImageView.clipsToBounds = true
        earthImageView.snp.makeConstraints { make in
            make.top.equalTo(venusImageView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.width.equalTo(earthImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.height.equalTo(maxHeightContainerBig)
        }
        
        earthLabel.textColor = .white
        earthLabel.text = "ЗЕМЛЯ"
        earthLabel.font = UIFont.systemFont(ofSize: 32, weight: .black)
        earthLabel.snp.makeConstraints { make in
            make.left.equalTo(earthImageView).offset(12)
            make.bottom.equalTo(earthImageView).inset(12)
        }
        
        marsImageView.image = UIImage(named: "mars")
        marsImageView.layer.cornerRadius = 25
        marsImageView.clipsToBounds = true
        marsImageView.snp.makeConstraints { make in
            make.top.equalTo(earthImageView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.width.equalTo(marsImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.height.equalTo(maxHeightContainerBig)
        }
        
        marsLabel.textColor = .white
        marsLabel.text = "МАРС"
        marsLabel.font = UIFont.systemFont(ofSize: 32, weight: .black)
        marsLabel.snp.makeConstraints { make in
            make.left.equalTo(marsImageView).offset(12)
            make.bottom.equalTo(marsImageView).inset(12)
        }
        
        jupiterImageView.image = UIImage(named: "jupiter")
        jupiterImageView.layer.cornerRadius = 25
        jupiterImageView.clipsToBounds = true
        jupiterImageView.snp.makeConstraints { make in
            make.top.equalTo(marsImageView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.width.equalTo(jupiterImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.height.equalTo(maxHeightContainerBig)
        }
        
        jupiterLabel.textColor = .white
        jupiterLabel.text = "ЮПИТЕР"
        jupiterLabel.font = UIFont.systemFont(ofSize: 32, weight: .black)
        jupiterLabel.snp.makeConstraints { make in
            make.left.equalTo(jupiterImageView).offset(12)
            make.bottom.equalTo(jupiterImageView).inset(12)
        }
        
        saturnImageView.image = UIImage(named: "saturn")
        saturnImageView.layer.cornerRadius = 25
        saturnImageView.clipsToBounds = true
        saturnImageView.snp.makeConstraints { make in
            make.top.equalTo(jupiterImageView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.width.equalTo(saturnImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.height.equalTo(maxHeightContainerBig)
        }
        
        saturnLabel.textColor = .white
        saturnLabel.text = "САТУРН"
        saturnLabel.font = UIFont.systemFont(ofSize: 32, weight: .black)
        saturnLabel.snp.makeConstraints { make in
            make.left.equalTo(saturnImageView).offset(12)
            make.bottom.equalTo(saturnImageView).inset(12)
        }
        
        uranusImageView.image = UIImage(named: "uranus")
        uranusImageView.layer.cornerRadius = 25
        uranusImageView.clipsToBounds = true
        uranusImageView.snp.makeConstraints { make in
            make.top.equalTo(saturnImageView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.width.equalTo(uranusImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.height.equalTo(maxHeightContainerBig)
        }
        
        uranusLabel.textColor = .white
        uranusLabel.text = "УРАН"
        uranusLabel.font = UIFont.systemFont(ofSize: 32, weight: .black)
        uranusLabel.snp.makeConstraints { make in
            make.left.equalTo(uranusImageView).offset(12)
            make.bottom.equalTo(uranusImageView).inset(12)
        }
        
        neptuneImageView.image = UIImage(named: "neptune")
        neptuneImageView.layer.cornerRadius = 25
        neptuneImageView.clipsToBounds = true
        neptuneImageView.snp.makeConstraints { make in
            make.top.equalTo(uranusImageView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.width.equalTo(neptuneImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.height.equalTo(maxHeightContainerBig)
        }
        
        neptuneLabel.textColor = .white
        neptuneLabel.text = "НЕПТУН"
        neptuneLabel.font = UIFont.systemFont(ofSize: 32, weight: .black)
        neptuneLabel.snp.makeConstraints { make in
            make.left.equalTo(neptuneImageView).offset(12)
            make.bottom.equalTo(neptuneImageView).inset(12)
        }
        
        plutoImageView.image = UIImage(named: "pluto")
        plutoImageView.layer.cornerRadius = 25
        plutoImageView.clipsToBounds = true
        plutoImageView.snp.makeConstraints { make in
            make.top.equalTo(neptuneImageView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(24)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.width.equalTo(plutoImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.height.equalTo(maxHeightContainerBig)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        plutoLabel.textColor = .white
        plutoLabel.text = "ПЛУТОН"
        plutoLabel.font = UIFont.systemFont(ofSize: 32, weight: .black)
        plutoLabel.snp.makeConstraints { make in
            make.left.equalTo(plutoImageView).offset(12)
            make.bottom.equalTo(plutoImageView).inset(12)
        }
        
    }
    
   
    

}
