//
//  JTAppleCalendarViewDataSource.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/11/19.
//

import JTAppleCalendar

extension SearchDatePopover: JTAppleCalendarViewDataSource {
    private static let DATE_FORMAT_FULL = "yyyy MM dd"
    private static let START_DATE = "2015 01 01"
    private static let END_DATE = "2020 01 01"
    
    internal func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = SearchDatePopover.DATE_FORMAT_FULL
        let startDate = formatter.date(from: SearchDatePopover.START_DATE)!
        let endDate = formatter.date(from: SearchDatePopover.END_DATE)!
        return ConfigurationParameters(startDate: startDate, endDate: endDate, firstDayOfWeek: .monday)
    }
}
