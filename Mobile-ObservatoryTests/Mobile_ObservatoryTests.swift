//
//  Mobile_ObservatoryTests.swift
//  Mobile-ObservatoryTests
//
//  Created by andrewoch on 08.04.2022.
//

import XCTest
@testable import Mobile_Observatory
import SwiftDate

class Mobile_ObservatoryTests: XCTestCase {
    
    let coreDataService: CoreDataService = CoreDataService.shared

    override func setUp() {
        coreDataService.deleteAllArticles()
    }
    
    override func setUpWithError() throws {
        
    }

    override class func tearDown() {
    
    }
    
    override func tearDownWithError() throws {
        
    }
    
    //MARK: - Tests
    
    func testSavingArticleToCoreData() throws {
        let article: Article = Article(id: 0,
                                       title: "Hello",
                                       createdAt: Date(),
                                       summary: "summary",
                                       pictureUrl: URL(fileURLWithPath: "/"),
                                       pictureLocalPath: nil, articleUrl: URL(fileURLWithPath: "/"),
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
                                       pictureUrl: URL(fileURLWithPath: "/"),
                                       pictureLocalPath: nil, articleUrl: URL(fileURLWithPath: "/"),
                                       newsSite: "vigvamcev.com")
        
        coreDataService.saveArticle(article)
        coreDataService.deleteArticle(article)
        sleep(5)
        let entities: [Article] = coreDataService.getAllArticles()
        XCTAssertEqual(entities.count, 0)
    }

}
