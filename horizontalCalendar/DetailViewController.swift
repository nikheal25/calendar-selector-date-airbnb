//
//  DetailViewController.swift
//  horizontalCalendar
//
//  Created by Nick Gholap on 24/8/20.
//  Copyright © 2020 Nick Gholap. All rights reserved.
//

import UIKit
import HorizonCalendar

class DetailViewController: UIViewController {
    @IBOutlet weak var insideCalendarView: UIView!
//    private var selectedDay: Day?
//
//
//
//    private let monthsLayout: MonthsLayout
//
//    private lazy var calendar = Calendar(identifier: .gregorian)
//    private lazy var dayDateFormatter: DateFormatter = {
//      let dateFormatter = DateFormatter()
//      dateFormatter.calendar = calendar
//      dateFormatter.dateFormat = DateFormatter.dateFormat(
//        fromTemplate: "EEEE, MMM d, yyyy",
//        options: 0,
//        locale: calendar.locale ?? Locale.current)
//      return dateFormatter
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let calendarView = CalendarView(initialContent: makeContent())
        
        self.insideCalendarView.addSubview(calendarView)
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: insideCalendarView.layoutMarginsGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: insideCalendarView.layoutMarginsGuide.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: insideCalendarView.layoutMarginsGuide.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: insideCalendarView.layoutMarginsGuide.bottomAnchor),
        ])
        
    }
    
    private func makeContent() -> CalendarViewContent {
//        let selectedDay = self.selectedDay
        
        let calendar = Calendar(identifier: .gregorian)
        
        let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31))!
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        DayRangeSelectionDemoViewController.init(monthsLayout: .horizontal(monthWidth: min(min(view.bounds.width, view.bounds.height) - 64, 512)))
    }
}
