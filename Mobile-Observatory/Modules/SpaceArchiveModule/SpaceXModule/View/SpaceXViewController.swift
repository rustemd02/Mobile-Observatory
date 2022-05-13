//
//  SpaceXViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 12.05.2022.
//

import UIKit

protocol SpaceXViewControllerInput: AnyObject {

}

protocol SpaceXViewControllerOutput {
    

}

class SpaceXViewController: UIViewController {
    private var output: SpaceXViewControllerOutput
    
    init(output: SpaceXViewControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
   

}
