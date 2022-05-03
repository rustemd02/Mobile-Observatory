//
//  WeatherOnMarsDetailViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 22.04.2022.
//

import Foundation
import UIKit

protocol WeatherOnMarsDetailViewControllerInput: AnyObject {
    
}

protocol WeatherOnMarsDetailViewControllerOutput {
    func getWeatherInfo(sol: String, completion: @escaping (WeatherOnMarsInfo) -> Void)
}

class WeatherOnMarsDetailViewController: ViewController {
    private var output: WeatherOnMarsDetailViewControllerOutput
    
    
    var weatherOnMars: WeatherOnMarsInfo?
    
    var latestSol: Int?
    
    var currentSolLabel = UILabel()
    var backgroundImageView = UIImageView()
    var avgTemperatureLabel = UILabel()
    var maxAndMinTemperatureLabel = UILabel()
    var dateLabel = UILabel()
    
    var pressureLabel = UILabel()
    var pressureValueLabel = UILabel()
    
    var atmoOpacityValueLabel = UILabel()
    
    var monthOnMars = UILabel()
    var monthOnMarsValueLabel = UILabel()
    
    init(output: WeatherOnMarsDetailViewControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "calendar.circle"), style: .plain, target: self, action: #selector(changeSol))
        uiInit()
        latestSol = weatherOnMars?.sol
        configure()
    }
    
    
    func uiInit() {
        view.addSubview(backgroundImageView)
        view.addSubview(currentSolLabel)
        view.addSubview(avgTemperatureLabel)
        view.addSubview(dateLabel)
        view.addSubview(maxAndMinTemperatureLabel)
        view.addSubview(pressureLabel)
        view.addSubview(pressureValueLabel)
        view.addSubview(atmoOpacityValueLabel)
        view.addSubview(monthOnMars)
        view.addSubview(monthOnMarsValueLabel)
        
        view.backgroundColor = .white
        
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.layer.cornerRadius = 30
        backgroundImageView.clipsToBounds = true
        backgroundImageView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(-50)
        }
        backgroundImageView.image = UIImage(named: "weatherDetailBackground")
        
        currentSolLabel.textColor = .white
        currentSolLabel.layer.opacity = 50
        currentSolLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        currentSolLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView).offset(40)
            make.centerX.equalToSuperview()
        }
        
        atmoOpacityValueLabel.textColor = .white
        atmoOpacityValueLabel.font = UIFont.systemFont(ofSize: 26, weight: .light)
        atmoOpacityValueLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(avgTemperatureLabel).offset(-24)
        }
        
        avgTemperatureLabel.textColor = .white
        avgTemperatureLabel.font = UIFont.systemFont(ofSize: 60, weight: .heavy)
        avgTemperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-55)
        }
        
        maxAndMinTemperatureLabel.textColor = .white
        maxAndMinTemperatureLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        maxAndMinTemperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(avgTemperatureLabel).offset(16)
        }
        
        pressureValueLabel.textColor = .white
        pressureValueLabel.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        pressureValueLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(maxAndMinTemperatureLabel).offset(120)
        }
        
        pressureLabel.textColor = .white
        pressureLabel.text = "давление"
        pressureLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        pressureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(pressureValueLabel).offset(16)
        }
       
        dateLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.snp.makeConstraints { make in
            make.bottom.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
    }
  
    
    func configure() {
        guard let weatherOnMars = weatherOnMars else {
            return
        }
        avgTemperatureLabel.text = ((weatherOnMars.minTemp + weatherOnMars.maxTemp)/2).description + "°C"
        maxAndMinTemperatureLabel.text = "от " + weatherOnMars.minTemp.description + " °C, до " + weatherOnMars.maxTemp.description + " °C"
        currentSolLabel.attributedText = NSAttributedString(string: weatherOnMars.sol.description + " СОЛ", attributes: [.kern: 10])
        pressureValueLabel.text = weatherOnMars.pressure.description + " мм. рт. ст."
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let stringDate = dateFormatter.string(from: weatherOnMars.earthDate)
        dateLabel.text = "данные от " + stringDate
        
        atmoOpacityValueLabel.text = weatherOnMars.atmoOpacity
    }
    
    @objc func changeSol() {
        guard let latestSol = latestSol else {
            return
        }

        let alert = UIAlertController(title: "Введите сол", message: "но не больше \(latestSol)", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "сол"
            field.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Применить", style: .default, handler: { _ in
            guard let solField = alert.textFields?[0].text else { return }
            self.output.getWeatherInfo(sol: solField) { newWeatherInfo in
                self.weatherOnMars = newWeatherInfo
                self.configure()
            }
        }))
        present(alert, animated: true)
    }
   
}
