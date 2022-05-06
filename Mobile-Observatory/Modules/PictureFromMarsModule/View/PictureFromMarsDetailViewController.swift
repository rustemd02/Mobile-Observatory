//
//  PictureFromMarsDetailViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 05.05.2022.
//

import Foundation
import UIKit

protocol PictureFromMarsDetailViewControllerInput: AnyObject {
    
}

protocol PictureFromMarsDetailViewControllerOutput {
    
}

class PictureFromMarsDetailViewController: UIViewController {
    private var output: PictureFromMarsDetailViewControllerOutput
    
    var picFromMars: PictureFromMars?
    
    
    
    init(output: PictureFromMarsDetailViewControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
