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
    var interactor: SavedPostsInteractor

    init(){
        interactor = SavedPostsInteractor()
    }

    private func updateView() {
        view?.updateView(with: interactor.coreDataService.getAllSearchResults())
    }
}

extension SavedPostsPresenter: ViewControllerOutput {
    func viewDidLoad() {
        updateView()
    }

    func didSelectRow(at: Int) {

    }
    
    func didLoadData(){
        
    }
}

extension SavedPostsPresenter: LoginPresenterInput {
    func start() -> UIViewController {
        UIViewController()
    }
}
