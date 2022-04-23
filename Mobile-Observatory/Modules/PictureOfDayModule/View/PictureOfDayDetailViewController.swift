//
//  PictureOfDayViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 22.04.2022.
//

import UIKit

protocol PictureOfDayDetailViewControllerInput: AnyObject {
    
}

protocol PictureOfDayDetailViewControllerOutput {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
    func getPicOfDay(date: Date, completion: @escaping (PictureOfDay) -> Void)
}

class PictureOfDayDetailViewController: UIViewController {
    private var output: PictureOfDayDetailViewControllerOutput

    init(output: PictureOfDayDetailViewControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
