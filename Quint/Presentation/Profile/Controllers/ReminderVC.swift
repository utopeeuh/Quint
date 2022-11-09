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
    private var morningReminderView = CustomReminderView()
    public var morningTimePicker = TimePickerView()
    private var nightReminderView = CustomReminderView()
    public var nightTimePicker = TimePickerView()
    public let date = Date()
    
    public let isMorningReminderOn = UserDefaults.standard.object(forKey: K.UD.isMorningReminderOn) ?? false
    public let isNightReminderOn = UserDefaults.standard.object(forKey: K.UD.isNightReminderOn) ?? false
    public let morningReminderTime = UserDefaults.standard.object(forKey: K.UD.morningReminderTime) ?? false
    public let nightReminderTime = UserDefaults.standard.object(forKey: K.UD.nightReminderTime) ?? false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func configureComponents() {
        
        view.backgroundColor = K.Color.bgQuint
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        backButton.addTarget(self, action: #selector(backOnClick), for: .touchUpInside)

        titleLabel.text = "Reminder Settings"
        titleLabel.font = .interMedium(size: 16)
        titleLabel.textColor = K.Color.blackQuint
        
        morningReminderView.reminderSwitch.addTarget(self, action: #selector(morningSwitchOnClick), for: UIControl.Event.valueChanged)
        morningReminderView.setImage(UIImage(named: "iconMorning"))
        morningReminderView.setTitle("Morning")
        
        nightReminderView.reminderSwitch.addTarget(self, action: #selector(nightSwitchOnClick), for: UIControl.Event.valueChanged)
        nightReminderView.setImage(UIImage(named: "iconNight"))
        nightReminderView.setTitle("Night")

        morningTimePicker.changeDefaultTime(time: "07:00")
        nightTimePicker.changeDefaultTime(time: "19:00")
        
        morningTimePicker.alpha = 0
        nightTimePicker.alpha = 0
        
    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: backButton,
                                    titleLabel,
                                    morningReminderView,
                                    morningTimePicker,
                                    nightReminderView,
                                    nightTimePicker)
        
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
        
        morningReminderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(60)
        }
        
        morningTimePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(morningReminderView.snp.bottom).offset(16)
            make.width.equalTo(morningReminderView)
        }
        
        nightReminderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(morningReminderView.snp.bottom).offset(12)
            make.width.height.equalTo(morningReminderView)
        }
        
        nightTimePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nightReminderView.snp.bottom).offset(16)
            make.width.equalTo(morningReminderView)
        }
        
    }
    
    @objc func backOnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func morningSwitchOnClick(reminderSwitch: UISwitch) {
        
        if reminderSwitch.isOn {
            
            UIView.animate(withDuration: 0.2, animations: { [self] in
                nightReminderView.transform = CGAffineTransformMakeTranslation(0, 50)
                nightTimePicker.transform = CGAffineTransformMakeTranslation(0, 50)
                morningTimePicker.alpha = 1
            })
            
//            if isMorningReminderOn as! Bool == false {
//                morningTimePicker.timePicker.date = date
//                UserDefaults.standard.set(true, forKey: K.UD.morningReminderTime)
//            } else {
//                reminderSwitch.isOn = false
//            }
//
//            print(morningTimePicker.timePicker.date)
            
        } else {
            
            UIView.animate(withDuration: 0.2, animations: { [self] in
                nightReminderView.transform = CGAffineTransformMakeTranslation(0, 0)
                nightTimePicker.transform = CGAffineTransformMakeTranslation(0, 0)
                morningTimePicker.alpha = 0
            })
            
        }

    }
    
    @objc func nightSwitchOnClick(reminderSwitch: UISwitch) {
        
        if reminderSwitch.isOn {
            
            UIView.animate(withDuration: 0.2, animations: { [self] in
                nightTimePicker.alpha = 1
            })
            
//            if isNightReminderOn as! Bool == false {
//                nightTimePicker.timePicker.date = date
//                UserDefaults.standard.set(true, forKey: K.UD.nightReminderTime)
//            } else {
//                reminderSwitch.isOn = false
//            }
//            print(nightTimePicker.timePicker.date)
            
        } else {
            UIView.animate(withDuration: 0.2, animations: { [self] in
                nightTimePicker.alpha = 0
            })
        }

    }
    
}
