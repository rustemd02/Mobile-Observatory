//
//  SavedPostsInteractor.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import Foundation

class SavedPostsInteractor {
    
    private var coreDataService: CoreDataService
    
    init(){
        coreDataService = CoreDataService.shared
    }
    
    func getSavedArticles() -> [Article]{
        return coreDataService.getAllArticles()
    }
}
