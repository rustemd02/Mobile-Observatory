//
//  SpaceArchiveInteractor.swift
//  Mobile-Observatory
//
//  Created by Рустем on 12.05.2022.
//

import Foundation

protocol SpaceArchiveInteractorProtocol {
    func updateSearchResults(text: String, completion: @escaping () -> ())
    func didSelectRow(at: Int)
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt (indexPath: IndexPath) -> Item
}

class SpaceArchiveInteractor: SpaceArchiveInteractorProtocol {
    
    private let api = NetworkService.shared
    var results: [Item] = []
    
    func updateSearchResults(text: String, completion: @escaping () -> ()) {
        self.results = []
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        getSearchResults(text: text, completion: dispatchGroup.leave)
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    func getSearchResults(text: String, completion: @escaping () -> ()) {
        api.getSearchResults(searchQuery: text) { [weak self] result in
            switch result {
            case .success(let results):
                self?.results.append(contentsOf: results.collection.items)
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
    
    func didSelectRow(at: Int) {
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
       return results.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Item {
        return results[indexPath.row]
    }
}
