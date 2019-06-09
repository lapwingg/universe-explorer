//
//  PopoverViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import UIKit
import JTAppleCalendar

class PopoverViewController: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    var dateFactory: DateFactory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFactory = DateFactoryImpl()
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode   = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.scrollToDate(dateFactory.create(year: 2019, month: 06, day: 08))
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapped(_:)))
        calendarView.addGestureRecognizer(gesture)
    }
    
    @objc func didTapped(_ gesture: UITapGestureRecognizer) {
        print("OK - WHICH CELL? RETURN BACK CELL")
    }
    
    func configureCell(view: JTAppleCell?, cellState: CellState) {
        guard let cell = view as? DateCell  else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
//        handleCellSelected(cell: cell, cellState: cellState)
    }
    
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = UIColor.black
        } else {
            cell.dateLabel.textColor = UIColor.gray
        }
    }
    
////
//    func configureCell(view: JTAppleCell?, cellState: CellState) {
//        guard let cell = view as? DateCell  else { return }
//        cell.dateLabel.text = cellState.text
//        handleCellTextColor(cell: cell, cellState: cellState)
//
//    }

//    func handleCellSelected(cell: DateCell, cellState: CellState) {
//        if cellState.isSelected {
//            cell.selectedView.layer.cornerRadius =  13
//            cell.selectedView.isHidden = false
//        } else {
//            cell.selectedView.isHidden = true
//        }
//    }
//
//
//    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
//        configureCell(view: cell, cellState: cellState)
//    }
//
//    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
//        configureCell(view: cell, cellState: cellState)
//    }
}

extension PopoverViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2015 01 01")!
        let endDate = formatter.date(from: "2020 01 01")!
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
}

extension PopoverViewController: JTAppleCalendarViewDelegate {
//    func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) -> Bool {
//        return true // Based on a criteria, return true or false
//    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        let formatter = DateFormatter()  // Declare this outside, to avoid instancing this heavy class multiple times.
        formatter.dateFormat = "MMM YYYY"
        
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        header.monthYearTitle.text = formatter.string(from: range.start)
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: 50)
    }
}
