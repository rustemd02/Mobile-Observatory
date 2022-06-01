//
//  PictureOfDayPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 22.04.2022.
//

import Foundation
import UIKit

protocol PictureOfDayDetailPresenterProtocol {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
    func getPicOfDay(date: Date, completion: @escaping (PictureOfDay) -> Void)
}

class PictureOfDayDetailPresenter: PictureOfDayDetailPresenterProtocol {
    
    private let interactor: PictureOfDayDetailInteractorProtocol
    weak var view: PictureOfDayDetailViewControllerInput?
    
    init(interactor: PictureOfDayDetailInteractorProtocol) {
        self.interactor = interactor
    }
}

extension PictureOfDayDetailPresenter: PictureOfDayDetailViewControllerOutput {
    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
        return interactor.getImage(url: url, completion: completion)
    }
    func getPicOfDay(date: Date, completion: @escaping (PictureOfDay) -> Void) {
        return interactor.getPicOfDay(date: date, completion: completion)
    }
}
