//
//  PlanetDetailViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 22.05.2022.
//

import UIKit
import SnapKit


enum planets {
    case mercury
    case venus
    case earth
    case mars
    case jupiter
    case saturn
    case uranus
    case neptune
    case pluto
    
    
    func enumToString() -> String {
        return "\(self)"
    }
}


protocol PlanetDetailViewControllerInput: AnyObject {
    
}

protocol PlanetDetailViewControllerOutput {
    func getPlanetInfo(planet: planets, completion: @escaping (Planet) -> Void)
}

class PlanetDetailViewController: UIViewController {
    
    private var output: PlanetDetailViewControllerOutput
    var planetType: planets = .mercury
    var planet: Planet?
    
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    var imageView = UIImageView()
    
    var planetNameLabel = UILabel()
    var planetNameValue = UILabel()
    
    var massLabel = UILabel()
    var massValue = UILabel()
    
    var diameterLabel = UILabel()
    var diameterValue = UILabel()
    
    var gravityLabel = UILabel()
    var gravityValue = UILabel()

    var rotationPeriodLabel = UILabel()
    var rotationPeriodValue = UILabel()
    
    var lengthOfDayLabel = UILabel()
    var lengthOfDayValue = UILabel()
    
    var distanceFromSunLabel = UILabel()
    var distanceFromSunValue = UILabel()
    
    var orbitalVelocityLabel = UILabel()
    var orbitalVelocityValue = UILabel()
    
    var temperatureLabel = UILabel()
    var temperatureValue = UILabel()
    
    
    init(output: PlanetDetailViewControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.getPlanetInfo(planet: planetType) { planetInfo in
            self.planet = planetInfo
            self.configure()
        }
        uiInit()
    }
    
    private func uiInit () {
        view.backgroundColor = .white
        navigationItem.title = "О планете"
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(self.view)
        }
        
        contentView.addSubview(imageView)
        
        contentView.addSubview(planetNameLabel)
        contentView.addSubview(planetNameValue)
        
        contentView.addSubview(massLabel)
        contentView.addSubview(massValue)
        
        contentView.addSubview(diameterLabel)
        contentView.addSubview(diameterValue)
        
        contentView.addSubview(gravityLabel)
        contentView.addSubview(gravityValue)
        
        contentView.addSubview(rotationPeriodLabel)
        contentView.addSubview(rotationPeriodValue)
        
        contentView.addSubview(lengthOfDayLabel)
        contentView.addSubview(lengthOfDayValue)
        
        contentView.addSubview(distanceFromSunLabel)
        contentView.addSubview(distanceFromSunValue)
        
        contentView.addSubview(orbitalVelocityLabel)
        contentView.addSubview(orbitalVelocityValue)
        
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(temperatureValue)
        
        let maxWidthContainerBig: CGFloat = 374
        let maxHeightContainerBig: CGFloat = 225
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.width.equalTo(imageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        planetNameLabel.textColor = .black
        planetNameLabel.attributedText = NSAttributedString(string: "название по-английски", attributes: [.kern: 6])
        planetNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        planetNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp_bottomMargin).offset(32)
            make.centerX.equalToSuperview()
        }
        
        planetNameValue.textColor = .black
        planetNameValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        planetNameValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(planetNameLabel).offset(-6)
        }
        
        
        
        
        
    }
    
    
    func configure() {
        guard let planet = planet else {
            return
        }
        
        imageView.image = UIImage(named: planetType.enumToString())
        planetNameValue.text = planet.name
        massValue.text = planet.mass
        diameterValue.text = planet.diameter.description
        gravityValue.text = planet.gravity
        rotationPeriodValue.text = planet.rotationPeriod
        lengthOfDayValue.text = planet.lengthOfDay
        distanceFromSunValue.text = planet.distanceFromSun
        orbitalVelocityValue.text = planet.orbitalVelocity
        temperatureValue.text = planet.meanTemperature.description
    }
    
}



