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
    
    public func getAllPictureOfDay() -> [PictureOfDay]{
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
    
    // MARK: - Asteroids near Earth
    public func saveNearEarthAsteroids(_ nearEarthAsteroids: NearEarthAsteroids){
        persistentContainer.performBackgroundTask{ (context) in
            let nearEarthAsteroidsEntity = NearEarthAsteroidsEntity(context: context)
            nearEarthAsteroidsEntity.nextLink = nearEarthAsteroids.nextLink
            nearEarthAsteroidsEntity.prevLink = nearEarthAsteroids.prevLink
            let asteroids: NSSet = self.convertAsteroidsArrayToSet(asteroids: nearEarthAsteroids.asteroids)
            nearEarthAsteroidsEntity.addToAsteroids(asteroids)
            
            do {
                try context.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    public func getAllNearEarthAsteroids() -> [NearEarthAsteroids]{
        let fetchRequest = NearEarthAsteroidsEntity.fetchRequest()
        var entities: [NearEarthAsteroidsEntity] = []
        var feedEntities: [NearEarthAsteroids] = []
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
    
    private func convertAsteroidsArrayToSet(asteroids: [Asteroid]) -> NSSet {
        var asteroidsSet: [AsteroidEntity] = []
        for currentAsteroid in asteroids {
            var temp = currentAsteroid
            temp.uuid = UUID.init()
            saveAsteroid(temp)
            guard let savedEntity = getAsteroidEntity(uuid: temp.uuid!) else { continue }
            asteroidsSet.append(savedEntity)
        }
        return NSSet(array: asteroidsSet)
    }
    
    private func saveAsteroid(_ asteroid: Asteroid) {
        saveContext.perform {
            let asteroidEntity = AsteroidEntity(context: self.saveContext)
            asteroidEntity.update(with: asteroid)
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    private func getAsteroidEntity(uuid: UUID) -> AsteroidEntity?{
        let fetchRequest = AsteroidEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)
        
        do {
            guard let result = try viewContext.fetch(fetchRequest).first else { return nil }
            return result
        } catch {
            print(error)
        }
        return nil
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
            self.saveRover(photo.rover, photo: photoEntity)
            photoEntity.rover = self.getRoverEntity(id: photo.rover.id)
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
        saveContext.perform {
            let roverEntity = RoverEntity(context: self.saveContext)
            roverEntity.update(with: rover, photo: photo)
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
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
    
    // MARK: - Planet
    public func savePlanet(_ planet: Planet){
        saveContext.perform {
            let planetEntity = PlanetEntity(context: self.saveContext)
            planetEntity.update(with: planet)
            let moons: NSSet = self.convertMoonsArrayToSet(moons: planet.moons, planet: planetEntity)
            planetEntity.addToMoons(moons)
            
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    public func getAllPlanets() -> [Planet]{
        let fetchRequest = PlanetEntity.fetchRequest()
        var entities: [PlanetEntity] = []
        var feedEntities: [Planet] = []
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
    
    private func convertMoonsArrayToSet(moons: [String], planet: PlanetEntity) -> NSSet {
        var moonsSet: [MoonEntity] = []
        for currentMoon in moons {
            saveMoon(currentMoon, planet: planet)
            guard let temp = self.getMoonEntity(name: currentMoon) else { continue }
            moonsSet.append(temp)
        }
        return NSSet(array: moonsSet)
    }
    
    private func saveMoon(_ moon: String, planet: PlanetEntity){
        saveContext.perform {
            let moonEntity = MoonEntity(context: self.saveContext)
            moonEntity.moonName = moon
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    private func getMoonEntity(name: String) -> MoonEntity?{
        let fetchRequest = MoonEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "moonName == %@", name)
        do {
            guard let result = try viewContext.fetch(fetchRequest).first else { return nil }
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
    // MARK: - Search result
    public func saveSearchResult(_ searchResult: SearchResult){
        saveContext.perform {
            let searchResultEntity = SearchResultEntity(context: self.saveContext)
            let items = self.convertCollectionItemsArrayToSet(items: searchResult.collection.items, searchResult: searchResultEntity)
            searchResultEntity.addToItems(items)
            let links = self.convertCollectionLinksArrayToSet(links: searchResult.links ?? [], searchResult: searchResultEntity)
            searchResultEntity.addToCollectionLinks(links)
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    private func convertCollectionItemsArrayToSet(items: [Item], searchResult: SearchResultEntity) -> NSSet {
        var set: [SearchResultItemEntity] = []
        for current in items {
            let uuid = UUID.init()
            saveSearchResultItem(current, uuid: uuid, searchResult: searchResult)
            guard let temp = getSearchResultItemEntity(uuid: uuid) else { continue }
            set.append(temp)
        }
        return NSSet(array: set)
    }
    
    private func saveSearchResultItem(_ item: Item, uuid: UUID, searchResult: SearchResultEntity){
        saveContext.perform {
            let itemEntity = SearchResultItemEntity(context: self.saveContext)
            itemEntity.id = uuid
            itemEntity.href = item.href
            itemEntity.searchResult = searchResult
            
            let itemLinks = self.convertItemLinksArrayToSet(itemsLinks: item.links, searchResultItem: itemEntity)
            itemEntity.addToLinks(itemLinks)
            
            
            //TODO
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    private func convertDataArrayToSet(data: [Datum], searchResultItem: SearchResultItemEntity) -> NSSet {
        var set: [DatumEntity] = []
        for current in data {
            let uuid = UUID.init()
            saveDatum(current, uuid: uuid, searchResultItem: searchResultItem)
            guard let temp = getDatumEntity(uuid: uuid) else { continue }
            set.append(temp)
        }
        return NSSet(array: set)
    }
    
    private func saveDatum(_ datum: Datum, uuid: UUID, searchResultItem: SearchResultItemEntity){
        saveContext.perform {
            let datumEntity = DatumEntity(context: self.saveContext)
            datumEntity.id = uuid
            datumEntity.mediaType = datum.mediaType.rawValue
            datumEntity.createdAt = datum.dateCreated
            datumEntity.item = searchResultItem
            datumEntity.title = datum.title
            datumEntity.descr = datum.datumDescription
            datumEntity.nasaID = datum.nasaID
            datumEntity.photographer = datum.photographer
            
            //TODO
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    private func getDatumEntity(uuid: UUID) -> DatumEntity?{
        let fetchRequest = DatumEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)
        do {
            guard let result = try viewContext.fetch(fetchRequest).first else { return nil }
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
    private func convertItemLinksArrayToSet(itemsLinks: [ItemLink], searchResultItem: SearchResultItemEntity) -> NSSet {
        var set: [SearchResultItemLinkEntity] = []
        for current in itemsLinks {
            let uuid = UUID.init()
            saveSearchResultItemLink(current, uuid: uuid, searchResultItem: searchResultItem)
            guard let temp = getSearchResultItemLinkEntity(uuid: uuid) else { continue }
            set.append(temp)
        }
        return NSSet(array: set)
    }
    
    private func saveSearchResultItemLink(_ item: ItemLink, uuid: UUID, searchResultItem: SearchResultItemEntity){
        saveContext.perform {
            let itemLinkEntity = SearchResultItemLinkEntity(context: self.saveContext)
            itemLinkEntity.id = uuid
            itemLinkEntity.href = item.href
            itemLinkEntity.item = searchResultItem
            itemLinkEntity.mediaType = item.render?.rawValue
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    private func getSearchResultItemLinkEntity(uuid: UUID) -> SearchResultItemLinkEntity?{
        let fetchRequest = SearchResultItemLinkEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)
        do {
            guard let result = try viewContext.fetch(fetchRequest).first else { return nil }
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
    private func getSearchResultItemEntity(uuid: UUID) -> SearchResultItemEntity?{
        let fetchRequest = SearchResultItemEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)
        do {
            guard let result = try viewContext.fetch(fetchRequest).first else { return nil }
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
    private func convertCollectionLinksArrayToSet(links: [CollectionLink], searchResult: SearchResultEntity) -> NSSet {
        var set: [SearchResultCollectionLinkEntity] = []
        for current in links {
            let uuid = UUID.init()
            saveCollectionLink(current, uuid: uuid, searchResult: searchResult)
            guard let temp = getCollectionLinkEntity(uuid: uuid) else { continue }
            set.append(temp)
        }
        return NSSet(array: set)
    }
    
    private func saveCollectionLink(_ link: CollectionLink, uuid: UUID, searchResult: SearchResultEntity){
        saveContext.perform {
            let itemEntity = SearchResultCollectionLinkEntity(context: self.saveContext)
            itemEntity.id = uuid
            itemEntity.collection = searchResult
            itemEntity.href = link.href
            itemEntity.prompt = link.prompt
            itemEntity.rel = link.rel
            do {
                try self.saveContext.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    private func getCollectionLinkEntity(uuid: UUID) -> SearchResultCollectionLinkEntity?{
        let fetchRequest = SearchResultCollectionLinkEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)
        do {
            guard let result = try viewContext.fetch(fetchRequest).first else { return nil }
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
    public func getAllSearchResults() -> [SearchResult]{
        let fetchRequest = SearchResultEntity.fetchRequest()
        var entities: [SearchResultEntity] = []
        var feedEntities: [SearchResult] = []
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
    
    private func convertKeyWordsArrayToSet(keyWords: [String]) -> NSSet {
        var keyWordsSet: [KeyWordEntity] = []
        for currentKeyWord in keyWords {
            let temp = saveKeyWord(currentKeyWord)
            keyWordsSet.append(temp)
        }
        return NSSet(array: keyWordsSet)
    }
    
    private func saveKeyWord(_ keyWord: String) -> KeyWordEntity{
        let keyWordEntity = KeyWordEntity(context: viewContext)
        keyWordEntity.keyWord = keyWord
        
        do {
            try viewContext.save()
        } catch let error {
            print("Error: \(error)")
        }
        return keyWordEntity
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
}
