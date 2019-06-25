//
//  Created by Czajka, Kamil
//

import XCTest
@testable import asteroids

internal class JSONSerializerTest: XCTestCase {
    private var sut: JSONSerializer!
    
    override func setUp() {
        sut = JSONSerializer()
    }
    
    func testDecode() {
        let downloader = NASADownloadService()
        XCTAssertNoThrow(downloader.runDownload(date: Date().addingTimeInterval(-1 * 60 * 60 * 24), queryType: .pictureOfTheDay, completion: { data in
            self.sut.decode(ofType: PictureOfTheDay.self, data: data, completion: { pictureOfTheDay in })
        }))
        
        XCTAssertNoThrow(downloader.runDownload(date: Date().addingTimeInterval(-1 * 60 * 60 * 24), queryType: .marsRoverPhotos, completion: { data in
            self.sut.decode(ofType: MarsPhotosRoot.self, data: data, completion: { marsPhotosRoot in })
        }))
        
        XCTAssertNoThrow(downloader.runDownload(date: Date().addingTimeInterval(-1 * 60 * 60 * 24), queryType: .closestAsteroids, completion: { data in
            self.sut.decode(ofType: ClosestAsteroidsRoot.self, data: data, completion: { closestAsteroidsRoot in })
        }))
    }
}
