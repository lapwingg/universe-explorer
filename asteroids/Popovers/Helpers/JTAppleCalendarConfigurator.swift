//
//  JTAppleCalendarViewDataSource.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/11/19.
//

import JTAppleCalendar

extension SearchDatePopover: JTAppleCalendarViewDataSource {
    private static let START_DATE = (YEAR: 2015, MONTH: 01, DAY: 01)
    
    internal func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let rangeDates = createRangeDates()
        return ConfigurationParameters(startDate: rangeDates.start, endDate: rangeDates.end, firstDayOfWeek: .monday)
    }
    
    private func createRangeDates() -> (start: Date, end: Date) {
        let dateFactory = DateFactoryImpl()
        let startDate = dateFactory.create(year: SearchDatePopover.START_DATE.YEAR, month: SearchDatePopover.START_DATE.MONTH, day: SearchDatePopover.START_DATE.DAY)
        let endDate = getNextYear()
        return (startDate, endDate)
    }
    
    private func getNextYear() -> Date {
        return Calendar.current.date(byAdding: .year, value: 1, to: Date())!
    }
}
