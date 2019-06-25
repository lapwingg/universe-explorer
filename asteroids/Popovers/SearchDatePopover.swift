//
//  Created by Czajka, Kamil
//

import UIKit
import JTAppleCalendar

internal class SearchDatePopover: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    private var dateParser: DateParser!
    private var completionAction: ((Date) -> Void)?
    private var date: Date?
    private static var uiViewControllerFactory: UIViewControllerFactory!
    private static let POPOVER_NAME = "SearchDatePopover"
    private let OFFSET: Double = 60 * 60 * 2
    
    public static func create(controller: UIViewController, completion: ((Date) -> Void)?) -> UINavigationController {
        SearchDatePopover.uiViewControllerFactory = UIViewControllerFactoryImpl()
        let popoverContent = SearchDatePopover.uiViewControllerFactory.create(name: SearchDatePopover.POPOVER_NAME) as! SearchDatePopover
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
    
    private func configure() {
        setupServices()
        setupCalendarDelegates()
        setupCalendar()
    }
    
    internal func configureCell(view: JTAppleCell?, cellState: CellState, date: Date) {
        guard let cell = view as? DateCell  else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState, date: date)
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
    
    fileprivate func setupServices() {
        dateParser = DateParserImpl()
    }
    
    fileprivate func setupCalendarDelegates() {
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
    }
    
    fileprivate func getTodayDate() -> Date {
        return Date()
    }
    
    fileprivate func setupCalendar() {
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.scrollToDate(getTodayDate())
        calendarView.selectDates([getTodayDate()])
    }
}
