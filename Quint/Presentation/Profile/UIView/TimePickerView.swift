//
//  TimePickerView.swift
//  Quint
//
//  Created by Vendly on 07/11/22.
//

import UIKit
import SnapKit

class TimePickerView: UIView {
    
    private var setLabel = UILabel()
    public var timePicker = UIDatePicker()
    
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
    
    func changeDefaultTime(time: String) {
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"

        let picker = formatter.date(from: time)
        timePicker.date = picker!
        
    }
    
}
