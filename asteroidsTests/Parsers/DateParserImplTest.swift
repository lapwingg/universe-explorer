//
//  Created by Czajka, Kamil
//

import XCTest
@testable import asteroids

internal class DateParserImplTest: XCTestCase {
    private var sut: DateParserImpl!
    
    override func setUp() {
        sut = DateParserImpl()
    }
    
    func testParseToString() {
        let date = Date()
        XCTAssertNoThrow(sut.parseToString(date: date))
    }
    
    func testParseToStringWithFormat() {
        let date = Date()
        let format = "yyyy-MM-dd"
        XCTAssertNoThrow(sut.parseToString(date: date, format: format))
    }
}
