//
//  Created by Czajka, Kamil
//

import XCTest
@testable import asteroids

internal class NASADownloadServiceTest: XCTestCase {
    private var sut: NASADownloadService!
    
    override func setUp() {
        sut = NASADownloadService()
    }
    
    func testRunDownload() {
        XCTAssertNoThrow(sut.runDownload(date: Date().addingTimeInterval(-1 * 60 * 60 * 24), queryType: .pictureOfTheDay, completion: { data in }))
        XCTAssertNoThrow(sut.runDownload(date: Date().addingTimeInterval(-1 * 60 * 60 * 24), queryType: .marsRoverPhotos, completion: { data in }))
        XCTAssertNoThrow(sut.runDownload(date: Date().addingTimeInterval(-1 * 60 * 60 * 24), queryType: .closestAsteroids, completion: { data in }))
    }
}
