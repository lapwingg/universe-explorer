//
//  PopoverViewController.swift
//  asteroids
//
//  Created by Czajka, Kamil on 6/8/19.
//

import UIKit
import JTAppleCalendar

internal class SearchDatePopover: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    private var dateFactory: DateFactory!
    private var dateParser: DateParser!
    private var completionAction: ((Date) -> Void)?
    private var date: Date?
    private static let STORYBOARD_NAME = "Main"
    private static let POPOVER_NAME = "SearchDatePopover"
    private let DATE = (YEAR: 2019, MONTH: 06, DAY: 10)
    private let OFFSET: Double = 60 * 60 * 2
    
    public static func create(controller: UIViewController, completion: ((Date) -> Void)?) -> UINavigationController {
        let storyboard : UIStoryboard = UIStoryboard(name: STORYBOARD_NAME, bundle: nil)
        let popoverContent = storyboard.instantiateViewController(withIdentifier: POPOVER_NAME) as! SearchDatePopover
        let nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = .popover
        let popover = nav.popoverPresentationController
        popoverContent.preferredContentSize = CGSize(width: 250, height: 280)
        popover!.delegate = controller as? UIPopoverPresentationControllerDelegate
        popover!.sourceView = controller.view
        popover!.sourceRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        popoverContent.completionAction = completion
        popoverContent.loadViewIfNeeded()
        return nav
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
 
    @IBAction internal func buttonTapped(_ sender: UIButton) {
        completionAction?(date!)
        dismiss(animated: true)
    }
    
    internal func configureCell(view: JTAppleCell?, cellState: CellState, date: Date) {
        guard let cell = view as? DateCell  else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState, date: date)
    }
    
    private func configure() {
        setupHelpers()
        setupCalendarDelegates()
        setupCalendar()
    }
    
    private func handleCellTextColor(cell: DateCell, cellState: CellState) {
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
    
    private func handleCellSelected(cell: DateCell, cellState: CellState, date: Date) {
        if cellState.isSelected {
            cell.selectedView.layer.cornerRadius =  13
            cell.selectedView.isHidden = false
            self.date = date.addingTimeInterval(OFFSET)
        } else {
            cell.selectedView.isHidden = true
        }
    }
    
    fileprivate func setupHelpers() {
        dateFactory = DateFactoryImpl()
        dateParser = DateParserImpl()
    }
    
    fileprivate func setupCalendarDelegates() {
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
    }
    
    fileprivate func setupCalendar() {
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.scrollToDate(dateFactory.create(year: DATE.YEAR, month: DATE.MONTH, day: DATE.DAY))
        calendarView.selectDates([dateFactory.create(year: DATE.YEAR, month: DATE.MONTH, day: DATE.DAY)])
    }
}
