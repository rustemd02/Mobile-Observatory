//
//  Post.swift
//  Mobile-Observatory
//
//  Created by Рустем on 28.03.2022.
//

import Foundation

protocol Post {
    var isSaved: Bool? { get set }
    var postType: PostType? { get set }
}

enum PostType {
    
    case article
    case weatherOnMars
    case pictureOfDay
    case pictureFromMars
    case pictureOfEarth
    
    case asteroid
    case planet
    case searchResult
}
