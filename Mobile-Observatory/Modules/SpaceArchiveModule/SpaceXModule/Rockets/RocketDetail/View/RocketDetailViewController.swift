//
//  RocketDetailViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 24.05.2022.
//

import UIKit
import SnapKit

protocol RocketDetailViewControllerInput: AnyObject {
    
}

protocol RocketDetailViewControllerOutput {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
}

class RocketDetailViewController: UIViewController {
    
    private var output: RocketDetailViewControllerOutput
    
    var rocket: Rocket?
    
    var contentView = UIView()
    var scrollView = UIScrollView()
    
    var nameLabel = UILabel()
    var imageView = UIImageView()
    
    var descriptionLabel = UILabel()
    var descriptionValue = UILabel()
    var descriptionView = UIView()
    
    var countryLabel = UILabel()
    var countryValue = UILabel()
    var countryView = UIView()
    
    var companyLabel = UILabel()
    var companyValue = UILabel()
    var companyView = UIView()
    
    var heightLabel = UILabel()
    var heightValue = UILabel()
    var heightView = UIView()
    
    var massLabel = UILabel()
    var massValue = UILabel()
    var massView = UIView()
    
    var engineTypeLabel = UILabel()
    var engineTypeValue = UILabel()
    var engineTypeView = UIView()
    
    var engineFuelLabel = UILabel()
    var engineFuelValue = UILabel()
    var engineFuelView = UIView()
    
    var costPerLaunchLabel = UILabel()
    var costPerLaunchValue = UILabel()
    var costPerLaunchView = UIView()
    
    var successRateLabel = UILabel()
    var successRateValue = UILabel()
    var successRateView = UIView()
    
    var firstFlightDateLabel = UILabel()
    var firstFlightDateValue = UILabel()
    var firstFlightDateView = UIView()
    
    var wikiLinkButton = UIButton()
    var wikiLinkView = UIView()
    
    
    
    
    init(output: RocketDetailViewControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = rocket?.name
        uiInit()
        configure()
    }
    
    private func uiInit () {
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
        contentView.addSubview(imageView)
        
        
        contentView.addSubview(countryView)
        countryView.addSubview(countryLabel)
        countryView.addSubview(countryValue)
        
        contentView.addSubview(companyView)
        companyView.addSubview(companyLabel)
        companyView.addSubview(companyValue)
        
        contentView.addSubview(heightView)
        heightView.addSubview(heightLabel)
        heightView.addSubview(heightValue)
        
        contentView.addSubview(massView)
        massView.addSubview(massLabel)
        massView.addSubview(massValue)
        
        contentView.addSubview(engineTypeView)
        engineTypeView.addSubview(engineTypeLabel)
        engineTypeView.addSubview(engineTypeValue)
        
        contentView.addSubview(engineFuelView)
        engineFuelView.addSubview(engineFuelLabel)
        engineFuelView.addSubview(engineFuelValue)
        
        contentView.addSubview(costPerLaunchView)
        costPerLaunchView.addSubview(costPerLaunchLabel)
        costPerLaunchView.addSubview(costPerLaunchValue)
        
        contentView.addSubview(successRateView)
        successRateView.addSubview(successRateLabel)
        successRateView.addSubview(successRateValue)
        
        contentView.addSubview(firstFlightDateView)
        firstFlightDateView.addSubview(firstFlightDateLabel)
        firstFlightDateView.addSubview(firstFlightDateValue)
        
        contentView.addSubview(wikiLinkView)
        wikiLinkView.addSubview(wikiLinkButton)
        
        
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
        
        
        //MARK: Country
        countryView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        countryView.layer.cornerRadius = 12
        countryView.clipsToBounds = true
        countryView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        countryLabel.textColor = .black
        countryLabel.attributedText = NSAttributedString(string: "страна", attributes: [.kern: 6])
        countryLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        countryLabel.snp.makeConstraints { make in
            make.top.equalTo(countryView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        countryValue.textColor = .black
        countryValue.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        countryValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(countryLabel).offset(-14)
        }
        
        //MARK: Company
        companyView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        companyView.layer.cornerRadius = 12
        companyView.clipsToBounds = true
        companyView.snp.makeConstraints { make in
            make.top.equalTo(countryView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        companyLabel.textColor = .black
        companyLabel.attributedText = NSAttributedString(string: "принадлежит", attributes: [.kern: 6])
        companyLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        companyLabel.snp.makeConstraints { make in
            make.top.equalTo(companyView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        companyValue.textColor = .black
        companyValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        companyValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(companyLabel).offset(-14)
        }
        
        //MARK: Height
        heightView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        heightView.layer.cornerRadius = 12
        heightView.clipsToBounds = true
        heightView.snp.makeConstraints { make in
            make.top.equalTo(companyView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        heightLabel.textColor = .black
        heightLabel.attributedText = NSAttributedString(string: "высота", attributes: [.kern: 6])
        heightLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        heightLabel.snp.makeConstraints { make in
            make.top.equalTo(heightView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        heightValue.textColor = .black
        heightValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        heightValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(heightLabel).offset(-14)
        }
        
        //MARK: Mass
        massView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        massView.layer.cornerRadius = 12
        massView.clipsToBounds = true
        massView.snp.makeConstraints { make in
            make.top.equalTo(heightView.snp_bottomMargin).offset(16)
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
        
        //MARK: Engine Type
        engineTypeView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        engineTypeView.layer.cornerRadius = 12
        engineTypeView.clipsToBounds = true
        engineTypeView.snp.makeConstraints { make in
            make.top.equalTo(massView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        engineTypeLabel.textColor = .black
        engineTypeLabel.attributedText = NSAttributedString(string: "двигатель", attributes: [.kern: 6])
        engineTypeLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        engineTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(engineTypeView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        engineTypeValue.textColor = .black
        engineTypeValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        engineTypeValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(engineTypeLabel).offset(-14)
        }
        
        //MARK: Fuel Type
        engineFuelView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        engineFuelView.layer.cornerRadius = 12
        engineFuelView.clipsToBounds = true
        engineFuelView.snp.makeConstraints { make in
            make.top.equalTo(engineTypeView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        engineFuelLabel.textColor = .black
        engineFuelLabel.attributedText = NSAttributedString(string: "топливо", attributes: [.kern: 6])
        engineFuelLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        engineFuelLabel.snp.makeConstraints { make in
            make.top.equalTo(engineFuelView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        engineFuelValue.textColor = .black
        engineFuelValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        engineFuelValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(engineFuelLabel).offset(-14)
        }
        
        //MARK: Cost per launch
        costPerLaunchView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        costPerLaunchView.layer.cornerRadius = 12
        costPerLaunchView.clipsToBounds = true
        costPerLaunchView.snp.makeConstraints { make in
            make.top.equalTo(engineFuelView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        costPerLaunchLabel.textColor = .black
        costPerLaunchLabel.attributedText = NSAttributedString(string: "стоимость запуска", attributes: [.kern: 6])
        costPerLaunchLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        costPerLaunchLabel.snp.makeConstraints { make in
            make.top.equalTo(costPerLaunchView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        costPerLaunchValue.textColor = .black
        costPerLaunchValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        costPerLaunchValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(costPerLaunchLabel).offset(-14)
        }
        
        //MARK: Success rate
        successRateView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        successRateView.layer.cornerRadius = 12
        successRateView.clipsToBounds = true
        successRateView.snp.makeConstraints { make in
            make.top.equalTo(costPerLaunchView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        successRateLabel.textColor = .black
        successRateLabel.attributedText = NSAttributedString(string: "% успешных запусков", attributes: [.kern: 6])
        successRateLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        successRateLabel.snp.makeConstraints { make in
            make.top.equalTo(successRateView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        successRateValue.textColor = .black
        successRateValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        successRateValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(successRateLabel).offset(-14)
        }
        
        //MARK: First flight
        firstFlightDateView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        firstFlightDateView.layer.cornerRadius = 12
        firstFlightDateView.clipsToBounds = true
        firstFlightDateView.snp.makeConstraints { make in
            make.top.equalTo(successRateView.snp_bottomMargin).offset(16)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        firstFlightDateLabel.textColor = .black
        firstFlightDateLabel.attributedText = NSAttributedString(string: "первый полёт", attributes: [.kern: 6])
        firstFlightDateLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        firstFlightDateLabel.snp.makeConstraints { make in
            make.top.equalTo(firstFlightDateView.snp_topMargin).offset(24)
            make.centerX.equalToSuperview()
        }
        
        firstFlightDateValue.textColor = .black
        firstFlightDateValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        firstFlightDateValue.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(firstFlightDateLabel).offset(-14)
        }
        
        //MARK: WikiLink
        wikiLinkView.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        wikiLinkView.layer.cornerRadius = 12
        wikiLinkView.clipsToBounds = true
        wikiLinkView.snp.makeConstraints { make in
            make.top.equalTo(firstFlightDateView.snp_bottomMargin).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(64)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(64)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        wikiLinkButton.setTitle("подробнее на википедии", for: .normal)
        wikiLinkButton.setTitleColor(.link, for: .normal)
        wikiLinkButton.addTarget(self, action: #selector(openInSafari), for: .touchUpInside)
        wikiLinkButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(wikiLinkView)
        }
        
    }
    
    
    func configure() {
        guard let rocket = rocket else {
            return
        }
        output.getImage(url: rocket.flickrImages.first ?? "") { image in
            self.imageView.image = image
        }
        countryValue.text = rocket.country
        companyValue.text = rocket.company
        heightValue.text = (rocket.height.meters?.description ?? "") + " м."
        massValue.text = rocket.mass.kg.description + " кг"
        engineTypeValue.text = rocket.engines.type
        engineFuelValue.text = rocket.engines.propellant1
        successRateValue.text = rocket.successRatePct.description + "%"
        costPerLaunchValue.text = "$" + rocket.costPerLaunch.description
        firstFlightDateValue.text = rocket.firstFlight
        
    }
    
    @objc func openInSafari() {
        guard let rocket = rocket else {
            return
        }

        guard let url = URL(string: rocket.wikipedia) else { return }
        UIApplication.shared.open(url)
    }
}




