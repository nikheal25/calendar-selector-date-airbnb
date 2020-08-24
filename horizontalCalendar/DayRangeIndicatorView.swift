//
//  DayRangeIndicatorView.swift
//  horizontalCalendar
//
//  Created by Nick Gholap on 24/8/20.
//  Copyright © 2020 Nick Gholap. All rights reserved.
//

import UIKit

// MARK: - DayRangeIndicatorView

final class DayRangeIndicatorView: UIView {

  // MARK: Lifecycle

  init() {
    super.init(frame: .zero)
    backgroundColor = .clear
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  var framesOfDaysToHighlight = [CGRect]() {
    didSet {
      guard framesOfDaysToHighlight != oldValue else { return }
      setNeedsDisplay()
    }
  }

  override func draw(_ rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(UIColor.blue.withAlphaComponent(0.15).cgColor)

    // Get frames of day rows in the range
    var dayRowFrames = [CGRect]()
    var currentDayRowMinY: CGFloat?
    for dayFrame in framesOfDaysToHighlight {
      if dayFrame.minY != currentDayRowMinY {
        currentDayRowMinY = dayFrame.minY
        dayRowFrames.append(dayFrame)
      } else {
        let lastIndex = dayRowFrames.count - 1
        dayRowFrames[lastIndex] = dayRowFrames[lastIndex].union(dayFrame)
      }
    }

    // Draw rounded rectangles for each day row
    for dayRowFrame in dayRowFrames {
      let cornerRadius = dayRowFrame.height / 2
      let roundedRectanglePath = UIBezierPath(roundedRect: dayRowFrame, cornerRadius: cornerRadius)
      context?.addPath(roundedRectanglePath.cgPath)
      context?.fillPath()
    }
  }

}
