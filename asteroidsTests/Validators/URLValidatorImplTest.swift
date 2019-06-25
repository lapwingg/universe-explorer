//
//  Created by Czajka, Kamil
//

import XCTest
@testable import asteroids

internal class URLValidatorImplTest: XCTestCase {
    private var sut: URLValidatorImpl!
    
    override func setUp() {
        sut = URLValidatorImpl()
    }
    
    func testValidURL() {
        let url = URL(string: "http://abc.pl")
        XCTAssertNoThrow(sut.validate(url))
    }
}
