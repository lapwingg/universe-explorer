//
//  Created by Czajka, Kamil
//

import XCTest
@testable import asteroids

internal class URLQueryItemProviderImplTest: XCTestCase {
    private var sut: URLQueryItemProviderImpl!
    
    override func setUp() {
        sut = URLQueryItemProviderImpl()
    }
    
    func testGetAuthenticationItem() {
        XCTAssertNoThrow(sut.getAuthenticationItem())
    }
    
    func testProperQueryItems() {
        XCTAssertNoThrow(sut.get(queryType: .pictureOfTheDay, date: Date()))
        XCTAssertNoThrow(sut.get(queryType: .marsRoverPhotos, date: Date()))
        XCTAssertNoThrow(sut.get(queryType: .closestAsteroids, date: Date()))
    }
}
