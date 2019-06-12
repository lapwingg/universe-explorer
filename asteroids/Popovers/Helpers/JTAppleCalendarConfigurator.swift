//
//  JTAppleCalendarViewDataSource.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/11/19.
//

import JTAppleCalendar

extension SearchDatePopover: JTAppleCalendarViewDataSource {
    private static let START_DATE = (YEAR: 2015, MONTH: 01, DAY: 01)
    private static let END_DATE = (YEAR: 2020, MONTH: 01, DAY: 01)
    
    internal func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let rangeDates = createRangeDates()
        return ConfigurationParameters(startDate: rangeDates.start, endDate: rangeDates.end, firstDayOfWeek: .monday)
    }
    
    private func createRangeDates() -> (start: Date, end: Date) {
        let dateFactory = DateFactoryImpl()
        let startDate = dateFactory.create(year: SearchDatePopover.START_DATE.YEAR, month: SearchDatePopover.START_DATE.MONTH, day: SearchDatePopover.START_DATE.DAY)
        let endDate = dateFactory.create(year: SearchDatePopover.END_DATE.YEAR, month: SearchDatePopover.END_DATE.MONTH, day: SearchDatePopover.END_DATE.DAY)
        return (startDate, endDate)
    }
}
