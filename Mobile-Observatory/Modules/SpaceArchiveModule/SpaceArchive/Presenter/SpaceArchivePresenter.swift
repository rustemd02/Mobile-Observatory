//
//  SpaceArchivePresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 12.05.2022.
//

import Foundation

protocol SpaceArchivePresenterProtocol {
    
}

class SpaceArchivePresenter: SpaceArchivePresenterProtocol {
    private let interactor: SpaceArchiveInteractorProtocol
    weak var view: SpaceArchiveInput?
    
    init(interactor: SpaceArchiveInteractorProtocol) {
        self.interactor = interactor
    }
}

extension SpaceArchivePresenter: SpaceArchiveOutput {
    func viewDidLoad() {
    }
    
    func didSelectRow(at: Int) {
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        interactor.numberOfRowsInSection(section: section)
    }
    
    func itemForRowAt(indexPath: IndexPath) -> Item {
        interactor.cellForRowAt(indexPath: indexPath)
    }
    
    func updateSearchResults(text: String, completion: @escaping () -> ()) {
        interactor.updateSearchResults(text: text, completion: completion)
    }
}
