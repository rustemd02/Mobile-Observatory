//
//  WeatherOnMarsDetailViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 22.04.2022.
//

import Foundation

protocol WeatherOnMarsDetailViewControllerInput: AnyObject {
    
}

protocol WeatherOnMarsDetailViewControllerOutput {
    
}

class WeatherOnMarsDetailViewController: ViewController {
    private var output: WeatherOnMarsDetailViewControllerOutput
    
    init(output: WeatherOnMarsDetailViewControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiInit()
        configure()
    }
    
    func uiInit() {
        view.backgroundColor = .white
    }
    
    func configure() {
        
    }
}
