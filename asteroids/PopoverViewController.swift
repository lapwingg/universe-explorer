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
    var dateParser: DateParser!
    var completionAction: ((Date) -> Void)?
    var value: Date?
    
    public static func create(controller: UIViewController, completion: ((Date) -> Void)?) -> UINavigationController {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popoverContent = storyboard.instantiateViewController(withIdentifier: "SearchByDatePopover") as! PopoverViewController
        
        let nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = .popover
        let popover = nav.popoverPresentationController
        if UIDevice.current.userInterfaceIdiom == .pad {
            popoverContent.preferredContentSize = CGSize(width: 500, height: 500)
        } else {
            popoverContent.preferredContentSize = CGSize(width: 250, height: 280)
        }
        
        popover!.delegate = controller as? UIPopoverPresentationControllerDelegate
        popover!.sourceView = controller.view
        popover!.sourceRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        popoverContent.completionAction = completion
        popoverContent.loadViewIfNeeded()
        return nav
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFactory = DateFactoryImpl()
        dateParser = DateParserImpl()
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode   = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.scrollToDate(dateFactory.create(year: 2019, month: 06, day: 10))
        calendarView.selectDates([dateFactory.create(year: 2019, month: 06, day: 10)])
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print("OKK")
        completionAction?(value!)
        dismiss(animated: true)
    }
    
    func configureCell(view: JTAppleCell?, cellState: CellState, date: Date) {
        guard let cell = view as? DateCell  else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState, date: date)
    }
    
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            if cellState.day == .sunday {
                cell.dateLabel.textColor = UIColor.red
            } else {
                cell.dateLabel.textColor = UIColor.black
            }
        } else {
            cell.dateLabel.textColor = UIColor.gray
        }
    }
    
    func handleCellSelected(cell: DateCell, cellState: CellState, date: Date) {
        if cellState.isSelected {
            cell.selectedView.layer.cornerRadius =  13
            cell.selectedView.isHidden = false
            print(date.addingTimeInterval(60 * 60 * 2))
            value = date.addingTimeInterval(60 * 60 * 2)
            print(dateParser.parseToString(date: date.addingTimeInterval(60 * 60 * 2)))
        } else {
            cell.selectedView.isHidden = true
        }
    }

    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState, date: date)
    }

    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState, date: date)
    }
}

extension PopoverViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2015 01 01")!
        let endDate = formatter.date(from: "2020 01 01")!
        return ConfigurationParameters(startDate: startDate, endDate: endDate, firstDayOfWeek: .monday)
    }
}

extension PopoverViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) -> Bool {
        return true
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState, date: date)
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
