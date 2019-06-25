//
//  Created by Czajka, Kamil
//

import XCTest
@testable import asteroids

internal class ImageDownloadServiceImplTest: XCTestCase {
    private var sut: ImageDownloadServiceImpl!
    
    override func setUp() {
        sut = ImageDownloadServiceImpl()
    }
    
    func testRunDownload() {
        XCTAssertNoThrow(sut.runDownload(link: "https://apod.nasa.gov/apod/image/1906/25BrightestStars_Jittasaiyapan_1500.jpg", completion: { image in } ))
    }
}
