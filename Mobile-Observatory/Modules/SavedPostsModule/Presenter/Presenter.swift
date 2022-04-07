//
//  Presenter.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import Foundation
import UIKit

class SavedPostsPresenter {

    weak var view: ViewControllerInput?
//    private var dataService: DataServiceProtocol

//    init(dataService: DataServiceProtocol) {
//        self.dataService = dataService
//    }

    private func updateView() {
        view?.updateView(with: ["Albert", "Krasavchik"])
    }
}

extension SavedPostsPresenter: ViewControllerOutput {
    func viewDidLoad() {
        updateView()
    }

    func didSelectRow(at: Int) {

    }
}

extension SavedPostsPresenter: LoginPresenterInput {
    func start() -> UIViewController {
        UIViewController()
    }
}
//
//extension SavedPostsPresenter: RegistrationPresenterInput {
//    func start() -> UIViewController {
//        UIViewController()
//    }
//}
