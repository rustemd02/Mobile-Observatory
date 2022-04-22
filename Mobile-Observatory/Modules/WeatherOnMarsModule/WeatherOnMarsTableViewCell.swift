import UIKit

class WeatherOnMarsTableViewCell: UITableViewCell {
    let api = NetworkService.shared
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var solLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(sol: String) {
        let _ = api.getWeatherData(sol: sol) { [weak self] result in
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
