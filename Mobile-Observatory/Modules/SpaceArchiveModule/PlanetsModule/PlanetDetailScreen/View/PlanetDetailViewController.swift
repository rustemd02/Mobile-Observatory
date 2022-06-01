//
//  PlanetDetailViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 22.05.2022.
//

import UIKit
import SnapKit


enum Planets {
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
    func getPlanetInfo(planet: Planets, completion: @escaping (Planet) -> Void)
}

class PlanetDetailViewController: UIViewController {
    
    private var output: PlanetDetailViewControllerOutput
    var planetType: Planets = .mercury
    var planet: Planet?
    
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    var imageView = UIImageView()
    
    var planetNameLabel = UILabel()
    var planetNameValue = UILabel()
    var planetView = UIView()
    
    var massLabel = UILabel()
    var massValue = UILabel()
    var massView = UIView()
    
    var diameterLabel = UILabel()
    var diameterValue = UILabel()
    var diameterView = UIView()
    
    var gravityLabel = UILabel()
    var gravityValue = UILabel()
    var gravityView = UIView()

    var numberOfMoonsLabel = UILabel()
    var numberOfMoonsValue = UILabel()
    var numberOfMoonsView = UIView()
    
    var lengthOfDayLabel = UILabel()
    var lengthOfDayValue = UILabel()
    var lengthOfDayView = UIView()
    
    var distanceFromSunLabel = UILabel()
    var distanceFromSunValue = UILabel()
    var distanceFromSunView = UIView()
    
    var orbitalVelocityLabel = UILabel()
    var orbitalVelocityValue = UILabel()
    var orbitalVelocityView = UIView()
    
    var temperatureLabel = UILabel()
    var temperatureValue = UILabel()
    var temperatureView = UIView()
    
    
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
        
        contentView.addSubview(planetView)
        planetView.addSubview(planetNameLabel)
        planetView.addSubview(planetNameValue)
        
        contentView.addSubview(massView)
        massView.addSubview(massLabel)
        massView.addSubview(massValue)
        
        contentView.addSubview(diameterView)
        diameterView.addSubview(diameterLabel)
        diameterView.addSubview(diameterValue)
        
        contentView.addSubview(gravityView)
        gravityView.addSubview(gravityLabel)
        gravityView.addSubview(gravityValue)
        
        contentView.addSubview(numberOfMoonsView)
        numberOfMoonsView.addSubview(numberOfMoonsLabel)
        numberOfMoonsView.addSubview(numberOfMoonsValue)
        
        contentView.addSubview(lengthOfDayView)
        lengthOfDayView.addSubview(lengthOfDayLabel)
        lengthOfDayView.addSubview(lengthOfDayValue)
        
        contentView.addSubview(distanceFromSunView)
        distanceFromSunView.addSubview(distanceFromSunLabel)
        distanceFromSunView.addSubview(distanceFromSunValue)
        
        contentView.addSubview(orbitalVelocityView)
        orbitalVelocityView.addSubview(orbitalVelocityLabel)
        orbitalVelocityView.addSubview(orbitalVelocityValue)
        
        contentView.addSubview(temperatureView)
        temperatureView.addSubview(temperatureLabel)
        temperatureView.addSubview(temperatureValue)
        
        
        let maxWidthContainerBig: CGFloat = 374
        let maxHeightContainerBig: CGFloat = 225
        imageView.image = UIImage(named: "loading")
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.width.equalTo(imageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        //MARK: Name
        planetView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        planetView.layer.cornerRadius = 12
        planetView.clipsToBounds = true
        planetView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        planetNameLabel.textColor = .black
        planetNameLabel.attributedText = NSAttributedString(string: "название по-английски", attributes: [.kern: 6])
        planetNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        planetNameLabel.snp.makeConstraints { make in
            make.top.equalTo(planetView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        planetNameValue.textColor = .black
        planetNameValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        planetNameValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(planetNameLabel).offset(-14)
        }
        
        //MARK: Mass
        massView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        massView.layer.cornerRadius = 12
        massView.clipsToBounds = true
        massView.snp.makeConstraints { make in
            make.top.equalTo(planetView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        massLabel.textColor = .black
        massLabel.attributedText = NSAttributedString(string: "масса", attributes: [.kern: 6])
        massLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        massLabel.snp.makeConstraints { make in
            make.top.equalTo(massView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        massValue.textColor = .black
        massValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        massValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(massLabel).offset(-14)
        }
        
        //MARK: Diameter
        diameterView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        diameterView.layer.cornerRadius = 12
        diameterView.clipsToBounds = true
        diameterView.snp.makeConstraints { make in
            make.top.equalTo(massView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        diameterLabel.textColor = .black
        diameterLabel.attributedText = NSAttributedString(string: "диаметр", attributes: [.kern: 6])
        diameterLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        diameterLabel.snp.makeConstraints { make in
            make.top.equalTo(diameterView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        diameterValue.textColor = .black
        diameterValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        diameterValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(diameterLabel).offset(-14)
        }
        
        //MARK: Gravity
        gravityView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        gravityView.layer.cornerRadius = 12
        gravityView.clipsToBounds = true
        gravityView.snp.makeConstraints { make in
            make.top.equalTo(diameterView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        gravityLabel.textColor = .black
        gravityLabel.attributedText = NSAttributedString(string: "сила гравитации", attributes: [.kern: 6])
        gravityLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        gravityLabel.snp.makeConstraints { make in
            make.top.equalTo(gravityView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        gravityValue.textColor = .black
        gravityValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        gravityValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(gravityLabel).offset(-14)
        }
        
        //MARK: Rotation period
        numberOfMoonsView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        numberOfMoonsView.layer.cornerRadius = 12
        numberOfMoonsView.clipsToBounds = true
        numberOfMoonsView.snp.makeConstraints { make in
            make.top.equalTo(gravityView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        numberOfMoonsLabel.textColor = .black
        numberOfMoonsLabel.attributedText = NSAttributedString(string: "число спутников", attributes: [.kern: 6])
        numberOfMoonsLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        numberOfMoonsLabel.snp.makeConstraints { make in
            make.top.equalTo(numberOfMoonsView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        numberOfMoonsValue.textColor = .black
        numberOfMoonsValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        numberOfMoonsValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(numberOfMoonsLabel).offset(-14)
        }
        
        //MARK: Length of day
        lengthOfDayView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        lengthOfDayView.layer.cornerRadius = 12
        lengthOfDayView.clipsToBounds = true
        lengthOfDayView.snp.makeConstraints { make in
            make.top.equalTo(numberOfMoonsView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        lengthOfDayLabel.textColor = .black
        lengthOfDayLabel.attributedText = NSAttributedString(string: "продолжительность суток", attributes: [.kern: 6])
        lengthOfDayLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        lengthOfDayLabel.snp.makeConstraints { make in
            make.top.equalTo(lengthOfDayView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        lengthOfDayValue.textColor = .black
        lengthOfDayValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        lengthOfDayValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(lengthOfDayLabel).offset(-14)
        }
        
        //MARK: Distance from Sun
        distanceFromSunView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        distanceFromSunView.layer.cornerRadius = 12
        distanceFromSunView.clipsToBounds = true
        distanceFromSunView.snp.makeConstraints { make in
            make.top.equalTo(lengthOfDayView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        distanceFromSunLabel.textColor = .black
        distanceFromSunLabel.attributedText = NSAttributedString(string: "расстояние от солнца", attributes: [.kern: 6])
        distanceFromSunLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        distanceFromSunLabel.snp.makeConstraints { make in
            make.top.equalTo(distanceFromSunView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        distanceFromSunValue.textColor = .black
        distanceFromSunValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        distanceFromSunValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(distanceFromSunLabel).offset(-14)
        }
        
        //MARK: Velocity
        orbitalVelocityView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        orbitalVelocityView.layer.cornerRadius = 12
        orbitalVelocityView.clipsToBounds = true
        orbitalVelocityView.snp.makeConstraints { make in
            make.top.equalTo(distanceFromSunView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        orbitalVelocityLabel.textColor = .black
        orbitalVelocityLabel.attributedText = NSAttributedString(string: "скорость вращения", attributes: [.kern: 6])
        orbitalVelocityLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        orbitalVelocityLabel.snp.makeConstraints { make in
            make.top.equalTo(orbitalVelocityView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        orbitalVelocityValue.textColor = .black
        orbitalVelocityValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        orbitalVelocityValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(orbitalVelocityLabel).offset(-14)
        }
        
        
        //MARK: Temperature
        temperatureView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        temperatureView.layer.cornerRadius = 12
        temperatureView.clipsToBounds = true
        temperatureView.snp.makeConstraints { make in
            make.top.equalTo(orbitalVelocityView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        temperatureLabel.textColor = .black
        temperatureLabel.attributedText = NSAttributedString(string: "температура поверхности", attributes: [.kern: 6])
        temperatureLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        temperatureValue.textColor = .black
        temperatureValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        temperatureValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(temperatureLabel).offset(-14)
        }
        
    }
    
    
    func configure() {
        guard let planet = planet else {
            return
        }
        
        imageView.image = UIImage(named: planetType.enumToString())
        planetNameValue.text = planet.name
        massValue.text = planet.mass + " * 10²³ кг"
        diameterValue.text = planet.diameter.description + " км"
        gravityValue.text = planet.gravity + " м/с²"
        numberOfMoonsValue.text = planet.numberOfMoons.description
        lengthOfDayValue.text = planet.lengthOfDay + " ч."
        distanceFromSunValue.text = planet.distanceFromSun + " млн. км."
        orbitalVelocityValue.text = planet.orbitalVelocity + " км/c"
        temperatureValue.text = planet.meanTemperature.description + " °C"
    }
    
}



