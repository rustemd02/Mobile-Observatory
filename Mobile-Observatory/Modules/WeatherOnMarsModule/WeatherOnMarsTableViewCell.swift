import UIKit

class WeatherOnMarsTableViewCell: UITableViewCell {
    let api = NetworkService.shared
    
    var currentlyOnMarsLabel = UILabel()
    var backgroundImageView = UIImageView()
    var temperatureLabel = UILabel()
    var dateLabel = UILabel()
    
    var weatherOnMars: WeatherOnMarsInfo?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        uiInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func uiInit() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(currentlyOnMarsLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(dateLabel)
        
        backgroundImageView.image = UIImage(named: "loading")
        backgroundImageView.layer.cornerRadius = 25
        backgroundImageView.clipsToBounds = true
        backgroundImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.right.bottom.equalToSuperview().inset(16)
            make.height.lessThanOrEqualTo(200)
        }
        
        
        currentlyOnMarsLabel.textColor = .white
        currentlyOnMarsLabel.attributedText = NSAttributedString(string: "ПОГОДА НА МАРСЕ", attributes: [.kern: 6])
        currentlyOnMarsLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        currentlyOnMarsLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView).offset(8)
            make.centerX.equalToSuperview()
        }
        
        
        temperatureLabel.font = UIFont.systemFont(ofSize: 60, weight: .heavy)
        temperatureLabel.textColor = .white
        temperatureLabel.text = ""
        temperatureLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        dateLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.snp.makeConstraints { make in
            make.bottom.right.equalTo(backgroundImageView).inset(12)
        }
        
        
    }
    
    func configure() {
        guard let weatherOnMars = weatherOnMars else {
            return
        }
        self.temperatureLabel.text = (weatherOnMars.minTemp.description) + "°C"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let stringDate = dateFormatter.string(from: weatherOnMars.earthDate)
        self.dateLabel.text = "данные от " + stringDate
        self.backgroundImageView.image = UIImage(named: "WeatherOnMarsBackground")
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
