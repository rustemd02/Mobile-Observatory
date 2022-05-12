//
//  PictureFromMarsDetailPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 05.05.2022.
//

import Foundation
import UIKit

protocol PictureFromMarsDetailPresenterProtocol {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
    func getPicFromMars(date: Date, completion: @escaping (PictureFromMars) -> Void)
}

class PictureFromMarsDetailPresenter: PictureFromMarsDetailPresenterProtocol {
    private let interactor: PictureFromMarsDetailInteractorProtocol
    weak var view: PictureFromMarsDetailViewControllerInput?
    
    init(interactor: PictureFromMarsDetailInteractorProtocol) {
        self.interactor = interactor
    }
}

extension PictureFromMarsDetailPresenter: PictureFromMarsDetailViewControllerOutput {
    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
        return interactor.getImage(url: url, completion: completion)
    }
    
    func getPicFromMars(date: Date, completion: @escaping (PictureFromMars) -> Void) {
        return interactor.getPicFromMars(date: date, completion: completion)
    }
}
