//
//  LaunchViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 04.06.2022.
//

import Foundation
import UIKit

protocol LaunchViewControllerInput: AnyObject {
    
}

protocol LaunchViewControllerOutput {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
}

class LaunchViewController: UIViewController {
    
    var output: LaunchViewControllerOutput
    var launch: Launch?
    var contentView = UIView()
    var scrollView = UIScrollView()
    var launchImageView = UIImageView()
    private var infoPanels: [UIView]
    
    
    init(output: LaunchViewControllerOutput) {
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
        navigationItem.title = "Запуск"
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
        guard let launch = self.launch else { return }
        
        contentView.addSubview(launchImageView)
        let maxWidthContainerBig: CGFloat = 374
        let maxHeightContainerBig: CGFloat = 225
        launchImageView.image = UIImage(named: "loading")
        output.getImage(url: launch.links.patch?.large ?? "") { result in
            self.launchImageView.image = result
        }
        launchImageView.layer.cornerRadius = 25
        launchImageView.contentMode = .scaleAspectFit
        launchImageView.clipsToBounds = true
        launchImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.width.equalTo(launchImageView.snp.height).multipliedBy(maxWidthContainerBig/maxHeightContainerBig)
            make.width.height.equalTo(contentView.safeAreaLayoutGuide).priority(.high)
        }
        
        addInfoPanel(title: "НАЗВАНИЕ", value: launch.name)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let stringDate = dateFormatter.string(from: launch.dateLocal)
        
        addInfoPanel(title: "ДАТА", value: stringDate)
        addInfoPanel(title: "НОМЕР ЗАПУСКА", value: launch.flightNumber.description)

        if (launch.success ?? false) {
            addInfoPanel(title: "УСПЕШНО?", value: "Да")
        } else if (launch.success == false){
            addInfoPanel(title: "УСПЕШНО?", value: "Нет")
        }
        guard let videoLink = launch.links.webcast else { return }
        guard let wikiLink = launch.links.wikipedia else { return }
        addButton(title: "видео запуска", value: videoLink, action: #selector(openVideo))
        addButton(title: "подробнее на википедии", value: wikiLink, action: #selector(openWikiPage))
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
                make.top.equalTo(launchImageView.snp_bottomMargin).offset(16)
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

        infoPanels.append(panel)
    }
    
    func addButton(title: String, value: String, action: Selector) {
        let panel = UIView()
        contentView.addSubview(panel)
        
        panel.backgroundColor = #colorLiteral(red: 0.901840508, green: 0.901840508, blue: 0.901840508, alpha: 1)
        panel.layer.cornerRadius = 12
        panel.clipsToBounds = true
        panel.snp.makeConstraints { make in
            guard let prevPanel = infoPanels.last else { return }
            make.top.equalTo(prevPanel.snp_bottomMargin).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(64)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(64)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
        }
        
        let button = UIButton()
        panel.addSubview(button)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(panel)
        }
        infoPanels.append(panel)
    }
    
    @objc func openVideo() {
        guard let launch = launch else {
            return
        }
        guard let link = launch.links.webcast else { return }
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func openWikiPage() {
        guard let launch = launch else {
            return
        }
        guard let link = launch.links.wikipedia else { return }
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }
    
    func clearPanels() {
        for panel in infoPanels {
            panel.removeFromSuperview()
        }
        infoPanels = []
    }
}
