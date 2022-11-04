//
//  ReminderVC.swift
//  Quint
//
//  Created by Vendly on 31/10/22.
//

import UIKit
import SnapKit

class ReminderVC: UIViewController {
    
    private var backButton = BackButton()
    private var titleLabel = UILabel()
    private var view1 = DatePickerView()
    private var view2 = DatePickerView()
//    private var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func configureComponents() {
        
        view.backgroundColor = K.Color.bgQuint
        
        //        backButton.addTarget(self, action: #selector(backOnClick), for: .touchUpInside)

        titleLabel.text = "Reminder Settings"
        titleLabel.font = .interMedium(size: 16)
        titleLabel.textColor = K.Color.blackQuint
        
//        datePicker.datePickerMode = .countDownTimer
//        datePicker.minuteInterval = 2
        
        view1.isUserInteractionEnabled = true
        view1.setImage(UIImage(named: "iconMorning"))
        view1.setTitle("Morning")
        
        view2.isUserInteractionEnabled = true
        view2.setImage(UIImage(named: "iconNight"))
        view2.setTitle("Night")
        
    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: backButton,
                                    titleLabel,
                                    view1,
                                    view2)
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
        
        view1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.width.equalToSuperview().offset(-40)
        }
        
        view2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view1).offset(80)
            make.width.equalTo(view1)
        }
        
    }
    
    @objc func backOnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    
}
