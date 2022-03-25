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
    private let fileManager = LocalFileManager.shared
    
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
    
    lazy public var context = persistentContainer.viewContext
    
    // MARK: - Weather on Mars Info
    public func saveWeatherOnMarsInfo(_ weatherInfo: WeatherOnMarsInfo){
        persistentContainer.performBackgroundTask{ (context) in
            let weatherOnMarsInfoEntity = WeatherOnMarsInfoEntity(context: context)
            weatherOnMarsInfoEntity.update(with: weatherInfo)
            do {
                try context.save()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    // MARK: - Picture of day
    public func savePictureOfDay(_ pictureOfDay: PictureOfDay){
        persistentContainer.performBackgroundTask{ (context) in
            let pictureOfDayEntity = PictureOfDayEntity(context: context)
            
            pictureOfDayEntity.title = pictureOfDay.title
            pictureOfDayEntity.descr = pictureOfDay.description
            pictureOfDayEntity.image = imageData
            
            do {
                try context.save()
            } catch let error {
                print("Error: \(error)")
            }}
    }
    
    // MARK: - Asteroids near Earth
    public func saveNearEarthAsteroids(_ nearEarthAsteroids: NearEarthAsteroids){
        persistentContainer.performBackgroundTask{ (context) in
        let nearEarthAsteroidsEntity = NearEarthAsteroidsEntity(context: context)
        nearEarthAsteroidsEntity.nextLink = nearEarthAsteroids.nextLink.absoluteString
        nearEarthAsteroidsEntity.prevLink = nearEarthAsteroids.prevLink.absoluteString
        let asteroids: NSSet = convertAsteroidsArrayToSet(asteroids: nearEarthAsteroids.asteroids)
        nearEarthAsteroidsEntity.addToAsteroids(asteroids)
        
        do {
            try context.save()
        } catch let error {
            print("Error: \(error)")
        }
        }
    }
    
    private func convertAsteroidsArrayToSet(asteroids: [Asteroid]) -> NSSet {
        var asteroidsSet: [AsteroidEntity] = []
        for currentAsteroid in asteroids {
            saveAsteroid(currentAsteroid)
            let temp =
            asteroidsSet.append(temp)
        }
        return NSSet(array: asteroidsSet)
    }
    
    private func saveAsteroid(_ asteroid: Asteroid) -> AsteroidEntity{
        context.perform {
            <#code#>
        }
         persistentContainer.performBackgroundTask{ (context) in
            let asteroidEntity = AsteroidEntity(context: context)
            asteroidEntity.id = NSNumber(value: asteroid.id)
            asteroidEntity.approachDate = asteroid.approachDate
            asteroidEntity.estimatedDiameter = NSNumber(value: asteroid.estimatedDiameter)
            asteroidEntity.infoLink = asteroid.infoLink.absoluteString
            asteroidEntity.isHazardous = asteroid.isHazardous
            asteroidEntity.missDistance = NSNumber(value: asteroid.missDistance)
            asteroidEntity.velocity = NSNumber(value: asteroid.velocity)
            asteroidEntity.name = asteroid.name
            
            do {
                try context.save()
            } catch let error {
                print("Error: \(error)")
            }
            return asteroidEntity
        }
    }
    
    // MARK: - Picture from Mars
    public func savePictureFromMars(_ pictureFromMars: PictureFromMars){
        let pictureFromMarsEntity = PictureFromMarsEntity(context: context)
        let imageData = pictureFromMars.picture.pngData();
        pictureFromMarsEntity.rover = pictureFromMars.rover
        pictureFromMarsEntity.date = pictureFromMars.date
        pictureFromMarsEntity.picture = imageData
        
        do {
            try context.save()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    // MARK: - Picture of Earth
    public func savePictureOfEarth(_ pictureOfEarth: PictureOfEarth){
        let pictureOfEarthEntity = PictureOfEarthEntity(context: context)
        let imageData = pictureOfEarth.image.pngData();
        pictureOfEarthEntity.date = pictureOfEarth.date
        pictureOfEarthEntity.latitude = NSNumber(value: pictureOfEarth.latitude)
        pictureOfEarthEntity.longtitude = NSNumber(value: pictureOfEarth.longtitude)
        pictureOfEarthEntity.image = imageData
        
        do {
            try context.save()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    // MARK: - Planet
    public func savePlanet(_ planet: Planet){
        let planetEntity = PlanetEntity(context: context)
        planetEntity.name = planet.name
        planetEntity.bodyType = planet.bodyType
        planetEntity.discoveredWhen = planet.discoveredWhen
        planetEntity.gravity = NSNumber(value: planet.gravity)
        planetEntity.mass = NSNumber(value: planet.mass)
        planetEntity.radius = NSNumber(value: planet.radius)
        let moons: NSSet = convertMoonsArrayToSet(moons: planet.moons)
        planetEntity.addToMoons(moons)
        
        do {
            try context.save()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    private func convertMoonsArrayToSet(moons: [String]) -> NSSet {
        var moonsSet: [MoonEntity] = []
        for currentMoon in moons {
            let temp = saveMoon(currentMoon)
            moonsSet.append(temp)
        }
        return NSSet(array: moonsSet)
    }
    
    private func saveMoon(_ moon: String) -> MoonEntity{
        let moonEntity = MoonEntity(context: context)
        moonEntity.moonName = moon
        do {
            try context.save()
        } catch let error {
            print("Error: \(error)")
        }
        return moonEntity
    }
    
    // MARK: - Search result
    public func saveSearchResult(_ searchResult: SearchResult){
        let searchResultEntity = SearchResultEntity(context: context)
        searchResultEntity.title = searchResult.title
        searchResultEntity.createdAt = searchResult.createdAt
        searchResultEntity.descr = searchResult.description
        searchResultEntity.audioURL = searchResult.audioURL?.absoluteString
        searchResultEntity.image = searchResult.image?.pngData()
        searchResultEntity.credit = searchResult.credit
        searchResultEntity.mediaType = searchResult.mediaType.description
        searchResultEntity.nasaId = searchResult.nasaId
        searchResultEntity.videoURL = searchResult.videoURL?.absoluteString
        
        let keyWords: NSSet = convertKeyWordsArrayToSet(keyWords: searchResult.keyWords)
        searchResultEntity.addToKeyWords(keyWords)
        
        do {
            try context.save()
        } catch let error {
            print("Error: \(error)")
        }
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
        let keyWordEntity = KeyWordEntity(context: context)
        keyWordEntity.keyWord = keyWord
        
        do {
            try context.save()
        } catch let error {
            print("Error: \(error)")
        }
        return keyWordEntity
    }
    
    // MARK: - Article
    public func saveArticle(_ article: Article){
        let artcileEntity = ArticleEntity(context: context)
        let imageData = article.picture.pngData();
        artcileEntity.id = NSNumber(value: article.id)
        artcileEntity.title = article.title
        artcileEntity.articleUrl = article.articleUrl.absoluteString
        artcileEntity.createdAt = article.createdAt
        artcileEntity.newsSite = article.newsSite
        artcileEntity.summary = article.summary
        artcileEntity.picture = imageData
        
        do {
            try context.save()
        } catch let error {
            print("Error: \(error)")
        }
    }
}
