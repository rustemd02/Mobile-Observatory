//
//  LocalFileManager.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 20.03.2022.
//

import Foundation
import SwiftUI

class LocalFileManager{
    
    static let shared = LocalFileManager()
    
    func saveImage(image: UIImage, name:String) -> URL?{
        guard let data = image.jpegData(compressionQuality: 1.0),
              let path = getPathForImage(name: name) else {
                  print("Error saving image")
                  return nil
              }
        do{
            try data.write(to: path)
            print("Success saving")
            return path
        } catch let error{
            print("Error saving \(error)")
            return nil
        }
    }
    
    func getImageByURL(url: URL) -> UIImage?{
        if !FileManager.default.fileExists(atPath: url.path) {
            print("File does not exist")
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    func getPathForImage(name:String) -> URL? {
        guard let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent("\(name).jpeg") else {
                    print("Error finding path")
                    return nil
                }
        return path
    }
}
