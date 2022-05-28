//
//  Mobile_ObservatoryTests.swift
//  Mobile-ObservatoryTests
//
//  Created by andrewoch on 08.04.2022.
//

import XCTest
@testable import Mobile_Observatory
import SwiftDate

class MobileObservatory_CoreDataTests: XCTestCase {
    
    let coreDataService: CoreDataService = CoreDataService.shared

    override func setUp() {
        coreDataService.deleteAllArticles()
        coreDataService.deleteAllWeatherOnMarsInfos()
        coreDataService.deleteAllPicturesOfDay()
        coreDataService.deleteAllPlanets()
        coreDataService.deleteAllSearchResults()
        coreDataService.deleteAllPicturesFromMars()
        coreDataService.deleteAllNearEarthAsteroids()
        coreDataService.deleteAllPictureOfEarthElements()
    }
    
    override func setUpWithError() throws {
         
    }

    override class func tearDown() {
    
    }
    
    override func tearDownWithError() throws {
        
    }
    
    //MARK: - Article Tests
    
    func testSavingArticleToCoreData() throws {
        let article: Article = Article(id: 0,
                                       title: "Hello",
                                       createdAt: Date(),
                                       summary: "summary",
                                       pictureUrl: "/",
                                       pictureLocalPath: nil, articleUrl: "/",
                                       newsSite: "vigvamcev.com")
        coreDataService.saveArticle(article)
        sleep(1)
        let entities: [Article] = coreDataService.getAllArticles()
        XCTAssertTrue(entities.contains(where: { $0.title == article.title }))
    }
    
    func testDeletingArticlesFromCoreData() throws {
        let article: Article = Article(id: 5,
                                       title: "Delete this",
                                       createdAt: Date(),
                                       summary: "summary",
                                       pictureUrl: "/",
                                       pictureLocalPath: nil, articleUrl: "/",
                                       newsSite: "vigvamcev.com")
        coreDataService.saveArticle(article)
        coreDataService.deleteArticle(article)
        sleep(1)
        let entities: [Article] = coreDataService.getAllArticles()
        XCTAssertEqual(entities.count, 0)
    }
    
    //MARK: - WeatherOnMars Tests
    
    func testSavingWeatherOnMarsToCoreData() throws {
        let weatherOnMars: WeatherOnMarsInfo = WeatherOnMarsInfo(id: 0, sol: 1, earthDate: Date(), minTemp: 5, maxTemp: 10, pressure: 100, pressureString: "100", atmoOpacity: "3", monthOnMars: "5")
        coreDataService.saveWeatherOnMarsInfo(weatherOnMars)
        sleep(1)
        let entities: [WeatherOnMarsInfo] = coreDataService.getAllWeatherOnMarsInfo()
        XCTAssertTrue(entities.contains(where: { $0.earthDate == weatherOnMars.earthDate}))
    }
    
    func testDeletingWeatherOnMarsFromCoreData() throws {
        let weatherOnMars: WeatherOnMarsInfo = WeatherOnMarsInfo(id: 0, sol: 1, earthDate: Date(), minTemp: 5, maxTemp: 10, pressure: 100, pressureString: "100", atmoOpacity: "3", monthOnMars: "5")
        coreDataService.saveWeatherOnMarsInfo(weatherOnMars)
        coreDataService.deleteWeatherOnMarsInfo(weatherOnMars)
        sleep(1)
        let entities: [WeatherOnMarsInfo] = coreDataService.getAllWeatherOnMarsInfo()
        XCTAssertEqual(entities.count, 0)
    }
    
    //MARK: - PictureOfDay Tests
    
    func testSavingPictureOfDayToCoreData() throws {
        let entity: PictureOfDay = PictureOfDay(uuid: nil, date: Date(), description: "Sample", title: "Picture of day", imageUrl: "/", imageLocalPath: nil)
        coreDataService.savePictureOfDay(entity)
        sleep(1)
        let entities: [PictureOfDay] = coreDataService.getAllPicturesOfDay()
        XCTAssertTrue(entities.contains(where: { $0.date == entity.date}))
    }
    
    func testDeletingPictureOfDayFromCoreData() throws {
        let entity: PictureOfDay = PictureOfDay(uuid: nil, date: Date(), description: "Sample", title: "Picture of day", imageUrl: "/", imageLocalPath: nil)
        coreDataService.savePictureOfDay(entity)
        coreDataService.deletePictureOfDay(entity)
        sleep(1)
        let entities: [PictureOfDay] = coreDataService.getAllPicturesOfDay()
        XCTAssertEqual(entities.count, 0)
    }
    
    //MARK: - Asteroids Tests
    
    func testSavingNearEarthAsteroidsToCoreData() throws {
        let entity: NearEarthAsteroids = NearEarthAsteroids(prevLink: "/", nextLink: "/", asteroids: [])
        
        coreDataService.saveNearEarthAsteroids(entity)
        sleep(1)
        let entities: [NearEarthAsteroids] = coreDataService.getAllNearEarthAsteroids()
        XCTAssertTrue(entities.contains(where: { $0.prevLink == entity.prevLink}))
    }
    
    func testDeletingNearEarthAsteroidsFromCoreData() throws {
        let entity: NearEarthAsteroids = NearEarthAsteroids(prevLink: "/", nextLink: "/", asteroids: [])
        coreDataService.saveNearEarthAsteroids(entity)
        coreDataService.deleteNearEarthAsteroids(entity)
        sleep(1)
        let entities: [NearEarthAsteroids] = coreDataService.getAllNearEarthAsteroids()
        XCTAssertEqual(entities.count, 0)
    }
    
    //MARK: - PictureFromMars Tests
    
    func testSavingPictureFromMarsToCoreData() throws {
        var entity: PictureFromMars = PictureFromMars(photos: [])
        entity.photos.append(Photo(uuid: nil,
                                               id: 1,
                                               sol: 234,
                                               imgSrc: "",
                                               imgLocalPath: "",
                                               earthDate: Date(),
                                               rover: Rover(id: 1, name: "Rover")))
        coreDataService.savePictureFromMars(entity)
        sleep(1)
        let entities: [PictureFromMars] = coreDataService.getAllPicturesFromMars()
        XCTAssertTrue(entities.contains(where: { $0.photos == entity.photos}))
    }
    
    func testDeletingPictureFromMarsFromCoreData() throws {
        let entity: PictureFromMars = PictureFromMars(photos: [])
        
        coreDataService.savePictureFromMars(entity)
        coreDataService.deletePictureFromMars(entity)
        sleep(1)
        let entities: [PictureFromMars] = coreDataService.getAllPicturesFromMars()
        XCTAssertEqual(entities.count, 0)
    }
    
    //MARK: - PictureOfEarth Tests
    
    func testSavingPictureOfEarthToCoreData() throws {
        let entity: PictureOfEarthElement = PictureOfEarthElement(imageUrl: "/", imageLocalPath: nil, centroidCoordinates: CentroidCoordinates(lat: 1, lon: 1), date: Date())
        
        coreDataService.savePictureOfEarth(entity)
        sleep(1)
        let entities: [PictureOfEarthElement] = coreDataService.getAllPicturesOfEarth()
        XCTAssertTrue(entities.contains(where: { $0.date == entity.date}))
    }
    
    func testDeletingPictureOfEarthFromCoreData() throws {
        let entity: PictureOfEarthElement = PictureOfEarthElement(imageUrl: "/", imageLocalPath: nil, centroidCoordinates: CentroidCoordinates(lat: 1, lon: 1), date: Date())
        
        coreDataService.savePictureOfEarth(entity)
        coreDataService.deletePictureOfEarth(entity)
        sleep(1)
        let entities: [PictureOfEarthElement] = coreDataService.getAllPicturesOfEarth()
        XCTAssertEqual(entities.count, 0)
    }

}
