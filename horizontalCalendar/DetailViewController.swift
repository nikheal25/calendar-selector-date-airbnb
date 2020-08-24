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
    private enum CalendarSelection {
        case singleDay(Day)
        case dayRange(DayRange)
    }
    private var calendarSelection: CalendarSelection?
    private lazy var calendarView = CalendarView(initialContent: makeContent())
    private lazy var calendar = Calendar(identifier: .gregorian)
    private lazy var dayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = calendar
        dateFormatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "EEEE, MMM d, yyyy",
            options: 0,
            locale: calendar.locale ?? Locale.current)
        return dateFormatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        calendarView.daySelectionHandler = { [weak self] day in
            guard let self = self else { return }
            
            switch self.calendarSelection {
            case .singleDay(let selectedDay):
                if day > selectedDay {
                    self.calendarSelection = .dayRange(selectedDay...day)
                } else {
                    self.calendarSelection = .singleDay(day)
                }
            case .none, .dayRange:
                self.calendarSelection = .singleDay(day)
            }
            
            self.calendarView.setContent(self.makeContent())
        }
        
        
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
        
//        let calendar = Calendar(identifier: .gregorian)
        
        let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31))!
        
        let calendarSelection = self.calendarSelection
        let dateRanges: Set<ClosedRange<Date>>
        if
            case .dayRange(let dayRange) = calendarSelection,
            let lowerBound = calendar.date(from: dayRange.lowerBound.components),
            let upperBound = calendar.date(from: dayRange.upperBound.components)
        {
            dateRanges = [lowerBound...upperBound]
        } else {
            dateRanges = []
        }
        
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
            .withDayItemProvider { day in
                let isSelected: Bool
                switch calendarSelection {
                case .singleDay(let selectedDay):
                    isSelected = day == selectedDay
                case .dayRange(let selectedDayRange):
                    isSelected = day == selectedDayRange.lowerBound || day == selectedDayRange.upperBound
                case .none:
                    isSelected = false
                }
                
                return CalendarItem<DayView, Day>(
                    viewModel: day,
                    styleID: isSelected ? "Selected" : "Default",
                    buildView: { DayView(isSelectedStyle: isSelected) },
                    updateViewModel: { [weak self] dayView, day in
                        dayView.dayText = "\(day.day)"
                        
                        if let date = self?.calendar.date(from: day.components) {
                            dayView.dayAccessibilityText = self?.dayDateFormatter.string(from: date)
                        } else {
                            dayView.dayAccessibilityText = nil
                        }
                    },
                    updateHighlightState: { dayView, isHighlighted in
                        dayView.isHighlighted = isHighlighted
                })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
