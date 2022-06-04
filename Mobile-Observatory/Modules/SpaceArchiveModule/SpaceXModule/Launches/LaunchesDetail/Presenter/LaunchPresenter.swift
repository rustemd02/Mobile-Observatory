//
//  LaunchPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 04.06.2022.
//

import Foundation
import UIKit

protocol LaunchPresenterProtocol {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
}

class LaunchPresenter: LaunchPresenterProtocol {
    
    private let interactor: LaunchInteractorProtocol
    weak var view: LaunchViewControllerInput?
    
    init(interactor: LaunchInteractorProtocol) {
        self.interactor = interactor
    }
   
}

extension LaunchPresenter: LaunchViewControllerOutput {
    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
        return interactor.getImage(url: url, completion: completion)
    }
    
    
    
}
