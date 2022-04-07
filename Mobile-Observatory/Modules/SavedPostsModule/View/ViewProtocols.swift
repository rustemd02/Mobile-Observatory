//
//  ViewProtocols.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import Foundation

protocol ViewControllerInput: AnyObject {
    func updateView(with items: [Post])
    func showError()
}

protocol ViewControllerOutput {
    func viewDidLoad()
    func didSelectRow(at: Int)
}
