//
//  Created by Czajka, Kamil
//

import XCTest
@testable import asteroids

internal class DateValidatorImplTest: XCTestCase {
    private var sut: DateValidatorImpl!
    
    override func setUp() {
        sut = DateValidatorImpl()
    }
    
    func testUnwrapDate() {
        let calendar = Calendar.init(identifier: .gregorian)
        let dateComponents = DateComponents(calendar: calendar, year: 2019, month: 05, day: 05)
        let date = dateComponents.date
        XCTAssertNoThrow(sut.validate(date))
    }
    
    func testDateComponentsCalendar() {
        let calendar = Calendar.init(identifier: .gregorian)
        let dateCompoments = DateComponents(year: 2019, month: 05, day: 05)
        XCTAssertNoThrow(sut.validate(dateComponents: dateCompoments, calendar: calendar))
    }
}
