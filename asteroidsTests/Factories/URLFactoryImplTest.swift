//
//  Created by Czajka, Kamil
//

import XCTest
@testable import asteroids

internal class URLFactoryImplTest: XCTestCase {
    private var sut: URLFactoryImpl!
    
    override func setUp() {
        sut = URLFactoryImpl()
    }
    
    func testCreateRequestUrlItems() {
        XCTAssertNoThrow(sut.createRequest(queryType: .closestAsteroids, date: Date()))
        XCTAssertNoThrow(sut.createRequest(queryType: .marsRoverPhotos, date: Date()))
        XCTAssertNoThrow(sut.createRequest(queryType: .pictureOfTheDay, date: Date()))
    }
    
    func testCreateRequestLink() {
        let link = "http://abc.pl"
        XCTAssertNoThrow(sut.createRequest(link: link))
    }
}
