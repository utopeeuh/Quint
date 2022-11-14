//
//  TimePickerView.swift
//  Quint
//
//  Created by Vendly on 07/11/22.
//

import UIKit
import SnapKit

class TimePickerView: UIView
{
    public static let defaultTime: Date = .now

    public let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        return calendar
    }()

    public let referenceDate = Date(timeIntervalSince1970: 0)

    public var onValueChanged: ((Date) -> Void)?

    private var setLabel = UILabel()

    public var date: Date { get { return timePicker.date } }

    // time interval since relative to 0
    // if set time (hour: 2, minute: 0, second: 0)
    // then return type should be 2 * 60 * 60 = 7200
    public var timeInterval: TimeInterval { get {
        timePicker.date.timeIntervalSince(referenceDate)
    }}

    public var hourComponent: Int { get {
        return calendar.component(.hour, from: date)
    }}

    public var minuteComponent: Int { get {
        return calendar.component(.minute, from: date)
    }}

    private var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.date = TimePickerView.defaultTime
        picker.timeZone = TimeZone(identifier: "UTC")
        return picker
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureComponents() {
        
        setLabel.text = "Set reminder time"
        setLabel.font = .interRegular(size: 15)
        setLabel.textColor = K.Color.blackQuint
        setLabel.textAlignment = .left

        timePicker.isUserInteractionEnabled = true
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        
    }
        
    override func configureLayout() {
        
        multipleSubviews(view: setLabel,
                               timePicker)
        
        setLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(16)
        }

        timePicker.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalToSuperview()
        }
        
    }

    @objc func datePickerChanged(picker: UIDatePicker) {
        onValueChanged?(picker.date)
    }

    public func setTime(hour: Int, minute: Int, second: Int) {
        let timeInterval = hour * 60 * 60 + minute * 60 + second
        timePicker.date = referenceDate.advanced(by: TimeInterval(timeInterval))
    }

    public func setTime(_ date: Date) {
        timePicker.date = date
    }
}
