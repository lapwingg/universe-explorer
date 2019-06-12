//
//  File.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/11/19.
//

import JTAppleCalendar

extension SearchDatePopover: JTAppleCalendarViewDelegate {
    private static let CELL_IDENTIFIER = "dateCell"
    private static let HEADER_IDENTIFIER = "dateHeader"
    private static let DATE_FORMAT_SHORT = "MMM YYYY"
    private static let MONTH_LONG: CGFloat = 50
    
    internal func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) -> Bool {
        return true
    }
    
    internal func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: SearchDatePopover.CELL_IDENTIFIER, for: indexPath) as! DateCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    internal func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState, date: date)
    }
    
    internal func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        let dateParser = DateParserImpl()
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: SearchDatePopover.HEADER_IDENTIFIER, for: indexPath) as! DateHeader
        header.monthYearTitle.text = dateParser.parseToString(date: range.start, format: SearchDatePopover.DATE_FORMAT_SHORT)
        return header
    }
    
    internal func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: SearchDatePopover.MONTH_LONG)
    }
    
    internal func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState, date: date)
    }
    
    internal func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState, date: date)
    }
}
