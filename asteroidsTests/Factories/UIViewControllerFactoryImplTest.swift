//
//  Created by Czajka, Kamil
//

import XCTest
@testable import asteroids

internal class UIViewControllerFactoryImplTest: XCTestCase {
    private var sut: UIViewControllerFactoryImpl!
    
    override func setUp() {
        sut = UIViewControllerFactoryImpl()
    }
    
    func testCreateUIViewController() {
        XCTAssertNoThrow(sut.create(name: "PictureOfTheDayFirstPage"))
    }
}
