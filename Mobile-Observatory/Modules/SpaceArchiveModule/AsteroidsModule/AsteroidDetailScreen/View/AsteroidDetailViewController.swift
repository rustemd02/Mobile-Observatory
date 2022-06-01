//
//  AsteroidDetailViewController.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 31.05.2022.
//

import Foundation
import UIKit

protocol AsteroidDetailInput {
    
}

protocol AsteroidDetailOutput {
    
}

class AsteroidDetailViewController: UIViewController {
    
    var output: AsteroidDetailOutput
    var asteroid: NearEarthObject?
    var contentView = UIView()
    var scrollView = UIScrollView()
    var asteroidImageView = UIImageView()
    private var infoPanels: [UIView]
    
    
    init(output: AsteroidDetailOutput) {
        self.output = output
        self.infoPanels = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.backgroundColor = .white
        navigationItem.title = "Астероид"
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(view)
        }
        
        clearPanels()
        guard let asteroid = self.asteroid else { return }
        
        contentView.addSubview(asteroidImageView)
        let maxWidthContainerBig: CGFloat = 374
        let maxHeightContainerBig: CGFloat = 225
        asteroidImageView.image = asteroid.image
        asteroidImageView.layer.cornerRadius = 25
        asteroidImageView.clipsToBounds = true
        asteroidImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(40)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.width.equalTo(asteroidImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.width.height.equalTo(contentView.safeAreaLayoutGuide).priority(.high)
        }
        
        addInfoPanel(title: "НАЗВАНИЕ", value: asteroid.name)
        addInfoPanel(title: "АБСОЛЮТНАЯ ВЕЛИЧИНА (H)", value: String(asteroid.absoluteMagnitudeH))
        let average =  (asteroid.estimatedDiameter.meters.estimatedDiameterMin + asteroid.estimatedDiameter.meters.estimatedDiameterMax) / 2
        addInfoPanel(title: "ДИАМЕТР", value: String(format: "%.3f", average) + " МЕТРОВ")
        if (asteroid.isPotentiallyHazardousAsteroid) {
            addInfoPanel(title: "ОПАСНОСТЬ", value: "ПОТЕНЦИАЛЬНО ОПАСЕН")
        } else {
            addInfoPanel(title: "ОПАСНОСТЬ", value: "НЕ ОПАСЕН")
        }
        guard let approachDatum = asteroid.closeApproachData.first else { return }
        addInfoPanel(title: "БУДЕТ БЛИЖЕ ВСЕГО К ЗЕМЛЕ", value: approachDatum.closeApproachDate)
        let velocity: Double = Double(approachDatum.relativeVelocity.kilometersPerSecond) ?? 0.0
        addInfoPanel(title: "СКОРОСТЬ ДВИЖЕНИЯ", value: String(format: "%.2f", velocity) + " КМ/С")
        let missDistance: Double = Double(approachDatum.missDistance.kilometers) ?? 0.0
        addInfoPanel(title: "РАССТОЯНИЕ ДО ЗЕМЛИ", value: String(format: "%.2f", missDistance) + " КМ")
        guard let lastPanel = infoPanels.last else { return }
        lastPanel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    private func addInfoPanel(title: String, value: String) {
        let panel = UIView()
        contentView.addSubview(panel)
        panel.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        panel.layer.cornerRadius = 12
        panel.clipsToBounds = true
        panel.snp.makeConstraints { make in
            if (infoPanels.count > 0) {
                guard let prevPanel = infoPanels.last else { return }
                make.top.equalTo(prevPanel.snp_bottomMargin).offset(16)
            } else {
                make.top.equalTo(asteroidImageView.snp_bottomMargin).offset(16)
            }
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(76)
        }
        
        let valueLabel = UILabel()
        panel.addSubview(valueLabel)
        valueLabel.textColor = .black
        valueLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        valueLabel.text = value
        valueLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
        }
        
        let titleLabel = UILabel()
        panel.addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.attributedText = NSAttributedString(string: title, attributes: [.kern: 6])
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(valueLabel).offset(32)
            make.bottom.equalTo(panel).inset(16)
        }

//        panel.snp.makeConstraints { make in
//            make.bottom.equalTo(titleLabel.snp.bottom)
//        }
        infoPanels.append(panel)
    }
    
    func clearPanels() {
        for panel in infoPanels {
            panel.removeFromSuperview()
        }
        infoPanels = []
    }
}
