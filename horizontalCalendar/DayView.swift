//
//  DayView.swift
//  horizontalCalendar
//
//  Created by Nick Gholap on 24/8/20.
//  Copyright © 2020 Nick Gholap. All rights reserved.
//

import UIKit

// MARK: - DayView

final class DayView: UIView {

  // MARK: Lifecycle

  init(isSelectedStyle: Bool) {
    super.init(frame: .zero)

    addSubview(dayLabel)

    layer.borderColor = UIColor.blue.cgColor
    layer.borderWidth = isSelectedStyle ? 2 : 0
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  var dayText: String {
    get { dayLabel.text ?? "" }
    set { dayLabel.text = newValue }
  }

  var dayAccessibilityText: String?

  var isHighlighted = false {
    didSet {
      updateHighlightIndicator()
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    dayLabel.frame = bounds
    layer.cornerRadius = min(bounds.width, bounds.height) / 2
  }

  // MARK: Private

  private lazy var dayLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 18)
    if #available(iOS 13.0, *) {
      label.textColor = .label
    } else {
      label.textColor = .black
    }
    return label
  }()

  private func updateHighlightIndicator() {
    backgroundColor = isHighlighted ? UIColor.black.withAlphaComponent(0.1) : .clear
  }

}

// MARK: UIAccessibility

extension DayView {

  override var isAccessibilityElement: Bool {
    get { true }
    set { }
  }

  override var accessibilityLabel: String? {
    get { dayAccessibilityText ?? dayText }
    set { }
  }

}
