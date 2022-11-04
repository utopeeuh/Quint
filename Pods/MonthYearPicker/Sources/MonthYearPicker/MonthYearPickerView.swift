//
//  MonthYearPickerView.swift
//  MonthYearPicker
//
//  Copyright (c) 2016 Alexander Edge <alex@alexedge.co.uk>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

open class MonthYearPickerView: UIControl {

    /// specify min date. default is nil. When `minimumDate` > `maximumDate`, the values are ignored.
    /// If `date` is earlier than `minimumDate` when it is set, `date` is changed to `minimumDate`.
    open var minimumDate: Date? = nil {
        didSet {
            guard let minimumDate = minimumDate, calendar.compare(minimumDate, to: date, toGranularity: .month) == .orderedDescending else { return }
            date = minimumDate
        }
    }

    /// specify max date. default is nil. When `minimumDate` > `maximumDate`, the values are ignored.
    /// If `date` is later than `maximumDate` when it is set, `date` is changed to `maximumDate`.
    open var maximumDate: Date? = nil {
        didSet {
            guard let maximumDate = maximumDate, calendar.compare(date, to: maximumDate, toGranularity: .month) == .orderedDescending else { return }
            date = maximumDate
        }
    }

    /// default is current date when picker created
    open var date: Date = Date() {
        didSet {
            if let minimumDate = minimumDate, calendar.compare(minimumDate, to: date, toGranularity: .month) == .orderedDescending {
                date = calendar.date(from: calendar.dateComponents([.year, .month], from: minimumDate)) ?? minimumDate
            } else if let maximumDate = maximumDate, calendar.compare(date, to: maximumDate, toGranularity: .month) == .orderedDescending {
                date = calendar.date(from: calendar.dateComponents([.year, .month], from: maximumDate)) ?? maximumDate
            }
            setDate(date, animated: true)
            sendActions(for: .valueChanged)
        }
    }

    /// default is current calendar when picker created
    open var calendar: Calendar = Calendar.autoupdatingCurrent {
        didSet {
            monthDateFormatter.calendar = calendar
            monthDateFormatter.timeZone = calendar.timeZone
            yearDateFormatter.calendar = calendar
            yearDateFormatter.timeZone = calendar.timeZone
        }
    }

    /// default is nil
    open var locale: Locale? {
        didSet {
            calendar.locale = locale
            monthDateFormatter.locale = locale
            yearDateFormatter.locale = locale
        }
    }

    lazy private var pickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: self.bounds)
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return pickerView
    }()

    lazy private var monthDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMM")
        return formatter
    }()
    
    lazy private var yearDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("y")
        return formatter
    }()
    
    fileprivate enum Component: Int {
        case month
        case year
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    private func initialSetup() {
        addSubview(pickerView)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        setDate(date, animated: false)
    }

    /// if animated is YES, animate the wheels of time to display the new date
    open func setDate(_ date: Date, animated: Bool) {
        guard let yearRange = calendar.maximumRange(of: .year), let monthRange = calendar.maximumRange(of: .month) else {
            return
        }
        let month = calendar.component(.month, from: date) - monthRange.lowerBound
        pickerView.selectRow(month, inComponent: .month, animated: animated)
        let year = calendar.component(.year, from: date) - yearRange.lowerBound
        pickerView.selectRow(year, inComponent: .year, animated: animated)
        pickerView.reloadAllComponents()
    }

    internal func isValidDate(_ date: Date) -> Bool {
        if let minimumDate = minimumDate,
            let maximumDate = maximumDate, calendar.compare(minimumDate, to: maximumDate, toGranularity: .month) == .orderedDescending { return true }
        if let minimumDate = minimumDate, calendar.compare(minimumDate, to: date, toGranularity: .month) == .orderedDescending { return false }
        if let maximumDate = maximumDate, calendar.compare(date, to: maximumDate, toGranularity: .month) == .orderedDescending { return false }
        return true
    }
    
}

extension MonthYearPickerView: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var dateComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
        dateComponents.year = value(for: pickerView.selectedRow(inComponent: .year), representing: .year)
        dateComponents.month = value(for: pickerView.selectedRow(inComponent: .month), representing: .month)
        guard let date = calendar.date(from: dateComponents) else { return }
        self.date = date
    }
    
}

extension MonthYearPickerView: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let component = Component(rawValue: component) else { return 0 }
        switch component {
        case .month:
            return calendar.maximumRange(of: .month)?.count ?? 0
        case .year:
            return calendar.maximumRange(of: .year)?.count ?? 0
        }
    }

    private func value(for row: Int, representing component: Calendar.Component) -> Int? {
        guard let range = calendar.maximumRange(of: component) else { return nil }
        return range.lowerBound + row
    }

    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label: UILabel = view as? UILabel ?? {
            let label = UILabel()
            if #available(iOS 10.0, *) {
                label.font = .preferredFont(forTextStyle: .title2, compatibleWith: traitCollection)
                label.adjustsFontForContentSizeCategory = true
            } else {
                label.font = .preferredFont(forTextStyle: .title2)
            }
            label.textAlignment = .center
            return label
        }()

        guard let component = Component(rawValue: component) else { return label }
        var dateComponents = calendar.dateComponents([.hour, .minute, .second], from: date)

        switch component {
            case .month:
                dateComponents.month = value(for: row, representing: .month)
                dateComponents.year = value(for: pickerView.selectedRow(inComponent: .year), representing: .year)
            case .year:
                dateComponents.month = value(for: pickerView.selectedRow(inComponent: .month), representing: .month)
                dateComponents.year = value(for: row, representing: .year)
        }

        guard let date = calendar.date(from: dateComponents) else { return label }

        switch component {
            case .month:
                label.text = monthDateFormatter.string(from: date)
            case .year:
                label.text = yearDateFormatter.string(from: date)
        }

        if #available(iOS 13.0, *) {
            label.textColor = isValidDate(date) ? .label : .secondaryLabel
        } else {
            label.textColor = isValidDate(date) ? .black : .lightGray
        }

        return label
    }
}

private extension UIPickerView {
    func selectedRow(inComponent component: MonthYearPickerView.Component) -> Int {
        selectedRow(inComponent: component.rawValue)
    }

    func selectRow(_ row: Int, inComponent component: MonthYearPickerView.Component, animated: Bool) {
        selectRow(row, inComponent: component.rawValue, animated: animated)
    }
}
