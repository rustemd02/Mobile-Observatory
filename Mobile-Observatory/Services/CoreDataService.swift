//
//  CoreDataService.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.03.2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataService{
    
    // MARK: - Properties
    static let shared = CoreDataService()
    private let fileManager = LocalFilesService.shared
    
    // MARK: - Core Data stack
    lazy public var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Mobile_Observatory")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {
    }
    
    lazy private var viewContext = persistentContainer.viewContext
    lazy private var saveContext = persistentContainer.newBackgroundContext()
    
    // MARK: - Weather on Mars Info
    public func saveWeatherOnMarsInfo(_ weatherInfo: WeatherOnMarsInfo){
        saveContext.perform {
            
            let weatherOnMarsInfoEntity = WeatherOnMarsInfoEntity(context: self.saveContext)
            weatherOnMarsInfoEntity.update(with: weatherInfo)
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    public func deleteWeatherOnMarsInfo(_ weatherOnMarsInfo: WeatherOnMarsInfo){
        saveContext.perform {
            let fetchRequest = WeatherOnMarsInfoEntity.fetchRequest()
            var entities: [WeatherOnMarsInfoEntity] = []
            do {
                entities = try self.saveContext.fetch(fetchRequest)
            } catch {
                print(error)
            }
            for entity in entities {
                let e = entity.convertToFeedEntity()
                if(e == weatherOnMarsInfo){
                    self.saveContext.delete(entity)
                    break
                }
            }
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    public func deleteAllWeatherOnMarsInfos(){
        saveContext.perform {
            let fetchRequest = WeatherOnMarsInfoEntity.fetchRequest()
            var entities: [WeatherOnMarsInfoEntity] = []
            do {
                entities = try self.saveContext.fetch(fetchRequest)
            } catch {
                print(error)
            }
            for entity in entities {
                self.saveContext.delete(entity)
            }
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    public func getAllWeatherOnMarsInfo() -> [WeatherOnMarsInfo]{
        let fetchRequest = WeatherOnMarsInfoEntity.fetchRequest()
        var weatherEntities: [WeatherOnMarsInfoEntity] = []
        var weatherInfos: [WeatherOnMarsInfo] = []
        do {
            weatherEntities = try viewContext.fetch(fetchRequest)
        } catch {
            print(error)
        }
        for entity in weatherEntities {
            weatherInfos.append(entity.convertToFeedEntity())
        }
        return weatherInfos
    }
    
    public func containsWeatherOnMars(sol: Int) -> Bool {
        let fetchRequest = WeatherOnMarsInfoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "sol == %@", sol as CVarArg)
        do {
            guard (try viewContext.fetch(fetchRequest).first) != nil else { return false }
            return true
        } catch {
            print(error)
        }
        return false
    }
    
    // MARK: - Picture of day
    public func savePictureOfDay(_ pictureOfDay: PictureOfDay){
        saveContext.perform {
            
            let entity = PictureOfDayEntity(context: self.saveContext)
            entity.update(with: pictureOfDay)
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }}
    }
    
    public func deletePictureOfDay(_ pictureOfDay: PictureOfDay){
        saveContext.perform {
            let fetchRequest = PictureOfDayEntity.fetchRequest()
            var entities: [PictureOfDayEntity] = []
            do {
                entities = try self.saveContext.fetch(fetchRequest)
            } catch {
                print(error)
            }
            for entity in entities {
                let e = entity.convertToFeedEntity()
                if(e == pictureOfDay){
                    self.saveContext.delete(entity)
                    break
                }
            }
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    public func deleteAllPicturesOfDay(){
        saveContext.perform {
            let fetchRequest = PictureOfDayEntity.fetchRequest()
            var entities: [PictureOfDayEntity] = []
            do {
                entities = try self.saveContext.fetch(fetchRequest)
            } catch {
                print(error)
            }
            for entity in entities {
                self.saveContext.delete(entity)
            }
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    public func getAllPicturesOfDay() -> [PictureOfDay]{
        let fetchRequest = PictureOfDayEntity.fetchRequest()
        var entities: [PictureOfDayEntity] = []
        var feedEntities: [PictureOfDay] = []
        do {
            entities = try viewContext.fetch(fetchRequest)
        } catch {
            print(error)
        }
        for entity in entities {
            feedEntities.append(entity.convertToFeedEntity())
        }
        return feedEntities
    }
    
    public func containsPictureOfDay(date: Date) -> Bool {
        let fetchRequest = PictureOfDayEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", date as CVarArg)
        do {
            guard (try viewContext.fetch(fetchRequest).first) != nil else { return false }
            return true
        } catch {
            print(error)
        }
        return false
    }
    
    // MARK: - Picture from Mars
    public func savePictureFromMars(_ pictureFromMars: PictureFromMars){
        saveContext.perform {
            
            let pictureFromMarsEntity = PicturesFromMarsCollectionEntity(context: self.saveContext)
            pictureFromMarsEntity.addToPictures(self.convertPhotosArrayToSet(photos: pictureFromMars.photos, collection: pictureFromMarsEntity))
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }}
    
    private func convertPhotosArrayToSet(photos: [Photo], collection: PicturesFromMarsCollectionEntity) -> NSSet {
        var set: [PictureFromMarsEntity] = []
        for currentAsteroid in photos {
            var temp = currentAsteroid
            temp.uuid = UUID.init()
            savePhotoFromMars(temp, collection: collection)
            guard let savedEntity = getPhotoFromMarsEntity(uuid: temp.uuid!) else { continue }
            set.append(savedEntity)
        }
        return NSSet(array: set)
    }
    
    private func savePhotoFromMars(_ photo: Photo, collection: PicturesFromMarsCollectionEntity) {
        saveContext.perform {
            let photoEntity = PictureFromMarsEntity(context: self.saveContext)
            photoEntity.update(with: photo, collection: collection)
            
            let roverEntity = RoverEntity(context: self.saveContext)
            roverEntity.update(with: photo.rover, photo: photoEntity)
            
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    private func getPhotoFromMarsEntity(uuid: UUID) -> PictureFromMarsEntity?{
        let fetchRequest = PictureFromMarsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)
        do {
            guard let result = try viewContext.fetch(fetchRequest).first else { return nil }
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
    private func saveRover(_ rover: Rover, photo: PictureFromMarsEntity) {
        
    }
    
    private func getRoverEntity(id: Int) -> RoverEntity?{
        let fetchRequest = RoverEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            guard let result = try viewContext.fetch(fetchRequest).first else { return nil }
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
    public func deletePictureFromMars(_ pictureFromMars: PictureFromMars){
        saveContext.perform {
            let fetchRequest = PicturesFromMarsCollectionEntity.fetchRequest()
            var entities: [PicturesFromMarsCollectionEntity] = []
            do {
                entities = try self.saveContext.fetch(fetchRequest)
            } catch {
                print(error)
            }
            for entity in entities {
                let e = entity.convertToFeedEntity()
                if(e == pictureFromMars){
                    self.saveContext.delete(entity)
                    break
                }
            }
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    public func deleteAllPicturesFromMars(){
        saveContext.perform {
            let fetchRequest = PictureFromMarsEntity.fetchRequest()
            var entities: [PictureFromMarsEntity] = []
            do {
                entities = try self.saveContext.fetch(fetchRequest)
            } catch {
                print(error)
            }
            for entity in entities {
                self.saveContext.delete(entity)
            }
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    public func getAllPicturesFromMars() -> [PictureFromMars]{
        let fetchRequest = PicturesFromMarsCollectionEntity.fetchRequest()
        var entities: [PicturesFromMarsCollectionEntity] = []
        var feedEntities: [PictureFromMars] = []
        do {
            entities = try viewContext.fetch(fetchRequest)
        } catch {
            print(error)
        }
        for entity in entities {
            feedEntities.append(entity.convertToFeedEntity())
        }
        return feedEntities
    }
    
    public func containsPictureFromMars(id: Int) -> Bool {
        let picturesFromMars = getAllPicturesFromMars()
        var contains = false
        for pictureFromMars in picturesFromMars {
            if(pictureFromMars.photos.first?.id == id){
                contains = true
            }
        }
        return contains
    }
    
    // MARK: - Picture of Earth
    public func savePictureOfEarth(_ pictureOfEarth: PictureOfEarthElement){
        saveContext.perform {
            let pictureOfEarthEntity = PictureOfEarthEntity(context: self.saveContext)
            pictureOfEarthEntity.update(with: pictureOfEarth)
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    public func deletePictureOfEarth(_ pictureOfEarthElement: PictureOfEarthElement){
        saveContext.perform {
            let fetchRequest = PictureOfEarthEntity.fetchRequest()
            var entities: [PictureOfEarthEntity] = []
            do {
                entities = try self.saveContext.fetch(fetchRequest)
            } catch {
                print(error)
            }
            for entity in entities {
                let e = entity.convertToFeedEntity()
                if(e == pictureOfEarthElement){
                    self.saveContext.delete(entity)
                    break
                }
            }
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    public func deleteAllPictureOfEarthElements(){
        saveContext.perform {
            let fetchRequest = PictureOfEarthEntity.fetchRequest()
            var entities: [PictureOfEarthEntity] = []
            do {
                entities = try self.saveContext.fetch(fetchRequest)
            } catch {
                print(error)
            }
            for entity in entities {
                self.saveContext.delete(entity)
            }
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    public func getAllPicturesOfEarth() -> [PictureOfEarthElement]{
        let fetchRequest = PictureOfEarthEntity.fetchRequest()
        var entities: [PictureOfEarthEntity] = []
        var feedEntities: [PictureOfEarthElement] = []
        do {
            entities = try viewContext.fetch(fetchRequest)
        } catch {
            print(error)
        }
        for entity in entities {
            feedEntities.append(entity.convertToFeedEntity())
        }
        return feedEntities
    }
    
    // MARK: - Article
    public func saveArticle(_ article: Article){
        saveContext.perform {
            let articleEntity = ArticleEntity(context: self.saveContext)
            articleEntity.update(with: article)
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    public func deleteArticle(_ article: Article){
        saveContext.perform {
            let fetchRequest = ArticleEntity.fetchRequest()
            var entities: [ArticleEntity] = []
            do {
                entities = try self.saveContext.fetch(fetchRequest)
            } catch {
                print(error)
            }
            for entity in entities {
                let e = entity.convertToFeedEntity()
                if(e == article){
                    self.saveContext.delete(entity)
                    break
                }
            }
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    public func deleteAllArticles(){
        saveContext.perform {
            let fetchRequest = ArticleEntity.fetchRequest()
            var entities: [ArticleEntity] = []
            do {
                entities = try self.saveContext.fetch(fetchRequest)
            } catch {
                print(error)
            }
            for entity in entities {
                self.saveContext.delete(entity)
            }
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    public func getAllArticles() -> [Article]{
        let fetchRequest = ArticleEntity.fetchRequest()
        var entities: [ArticleEntity] = []
        var feedEntities: [Article] = []
        do {
            entities = try viewContext.fetch(fetchRequest)
        } catch {
            print(error)
        }
        for entity in entities {
            feedEntities.append(entity.convertToFeedEntity())
        }
        return feedEntities
    }
    
    public func containsArticle(date: Date) -> Bool {
        let fetchRequest = ArticleEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "createdAt == %@", date as CVarArg)
        do {
            guard (try viewContext.fetch(fetchRequest).first) != nil else { return false }
            return true
        } catch {
            print(error)
        }
        return false
    }
}
