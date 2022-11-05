//
//  DatePickerView.swift
//  Quint
//
//  Created by Vendly on 31/10/22.
//

import UIKit
import SnapKit

class DatePickerView: UIView {
    
    private var iconImage = UIImageView()
    private var labelImage = UILabel()
    private var toggleSwitch = UISwitch()
    private var datePicker = UIDatePicker()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureComponents() {

        frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 60)

        applyGradient(colours: [K.Color.whiteQuint, K.Color.greyWhiteQuint], locations: [0,1], radius: 12)

        self.layer.shadowColor = K.Color.shadowQuint.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 0, height: 16)
        
        labelImage.text = ""
        labelImage.font = .interMedium(size: 16)
        labelImage.textColor = K.Color.blackQuint
        
        datePicker.isEnabled = true
        datePicker.datePickerMode = .countDownTimer
        datePicker.minuteInterval = 2
        
    }
        
    override func configureLayout() {

        multipleSubviews(view: iconImage,
                               labelImage,
                               toggleSwitch)
        
        iconImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalTo(14)
        }
        
        labelImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18.5)
            make.leading.equalTo(iconImage.snp.trailing).offset(12)
        }
        
        toggleSwitch.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14.5)
            make.trailing.equalToSuperview().offset(-14)
        }
        
    }
    
    func setImage(_ image: UIImage?) {
        iconImage.image = image
        sizeToFit()
    }
    
    func setTitle(_ title: String?) {
        labelImage.text = title
        sizeToFit()
    }
    
}
