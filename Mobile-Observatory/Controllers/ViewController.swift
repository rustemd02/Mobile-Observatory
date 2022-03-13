//
//  ViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 28.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15, *) {
            NetworkService.shared.getPicFromMars(date: Date.init(year: 2015, month: 10, day: 10, hour: 0, minute: 0)) {[weak self] result in
                print(result)
            }
        } else {
            // Fallback on earlier versions
        }
    }


}

