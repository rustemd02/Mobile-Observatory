//
//  WeatherOnMarsTableViewCell.swift
//  Mobile-Observatory
//
//  Created by Рустем on 26.03.2022.
//

import UIKit

class WeatherOnMarsTableViewCell: UITableViewCell {
    let api = NetworkService.shared
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var solLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure() {
        let _ = api.getWeatherData(sol: "") { [weak self] result in
            switch result {
            case .success(let weatherInfo):
                self?.temperatureLabel.text = weatherInfo.minTemp.description + "°C"
                self?.solLabel.text = weatherInfo.sol.description + " сол"
            case .failure(let error):
                print(error)
            }
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
