//
//  Created by Czajka, Kamil
//

import XCTest
@testable import asteroids

internal class URLComponentsProviderImplTest: XCTestCase {
    private var sut: URLComponentsProviderImpl!
    
    override func setUp() {
        sut = URLComponentsProviderImpl()
    }
    
    func testValidProvide() {
        XCTAssertNoThrow(sut.get(queryType: .pictureOfTheDay))
        XCTAssertNoThrow(sut.get(queryType: .marsRoverPhotos))
        XCTAssertNoThrow(sut.get(queryType: .closestAsteroids))
    }
}
