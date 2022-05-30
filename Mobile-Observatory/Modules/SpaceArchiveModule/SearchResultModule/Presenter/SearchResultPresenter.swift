//
//  SearchResultPresenter.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 28.05.2022.
//

import Foundation
import UIKit

class SearchResultPresenter: SearchResultDetailOutput {
   
    private let interactor: SearchResultInteractor
    weak var view: SearchResultDetailInput?
    
    init(interactor: SearchResultInteractor) {
        self.interactor = interactor
    }
    
    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
        interactor.getImage(url: url, completion: completion)
    }
}
