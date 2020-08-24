//
//  ViewController.swift
//  horizontalCalendar
//
//  Created by Nick Gholap on 24/8/20.
//  Copyright © 2020 Nick Gholap. All rights reserved.
//

import UIKit
import HorizonCalendar

class ViewController: UIViewController {
    @IBOutlet weak var viewForCalendar: UIView!
    
    private func makeContent() -> CalendarViewContent {
      let calendar = Calendar(identifier: .gregorian)

      let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
      let endDate = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31))!

      return CalendarViewContent(
        calendar: calendar,
        visibleDateRange: startDate...endDate,
        monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendarView = CalendarView(initialContent: self.makeContent())
        
        self.viewForCalendar.addSubview(calendarView)

        calendarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
          calendarView.leadingAnchor.constraint(equalTo: viewForCalendar.layoutMarginsGuide.leadingAnchor),
          calendarView.trailingAnchor.constraint(equalTo: viewForCalendar.layoutMarginsGuide.trailingAnchor),
          calendarView.topAnchor.constraint(equalTo: viewForCalendar.layoutMarginsGuide.topAnchor),
          calendarView.bottomAnchor.constraint(equalTo: viewForCalendar.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    


}

