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

    private var morningTimePicker: TimePickerView = {
        let picker = TimePickerView()
        picker.setTime(hour: 7, minute: 0, second: 0)
        return picker
    }()

    private var nightTimePicker: TimePickerView = {
        let picker = TimePickerView()
        picker.setTime(hour: 19, minute: 0, second: 0)
        return picker
    }()

    private var nightReminderView = CustomReminderView()

    private var morningReminderView = CustomReminderView()

    public let isMorningReminderOn = UserDefaults.standard.bool(forKey: K.UD.isMorningReminderOn)

    public let isNightReminderOn = UserDefaults.standard.bool(forKey: K.UD.isNightReminderOn)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        configureUI()
    }
    
    override func configureComponents() {
        
        view.backgroundColor = K.Color.bgQuint
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        backButton.addTarget(self, action: #selector(backOnClick), for: .touchUpInside)

        titleLabel.text = "Reminder Settings"
        titleLabel.font = .interMedium(size: 16)
        titleLabel.textColor = K.Color.blackQuint
        
        morningReminderView.setImage(UIImage(named: "iconMorning"))
        morningReminderView.setTitle("Morning")
        
        nightReminderView.setImage(UIImage(named: "iconNight"))
        nightReminderView.setTitle("Night")

        if let morningReminderTime = UserDefaults.standard.object(forKey: K.UD.morningReminderTime) as? Date
        {
            morningTimePicker.setTime(morningReminderTime)
        }
        if let nightReminderTime   = UserDefaults.standard.object(forKey: K.UD.nightReminderTime) as? Date
        {
            nightTimePicker.setTime(nightReminderTime)
        }
        
        if isMorningReminderOn {
            nightReminderView.transform = CGAffineTransformMakeTranslation(0, 50)
            nightTimePicker.transform = CGAffineTransformMakeTranslation(0, 50)
            morningTimePicker.alpha = 1
        } else {
            nightReminderView.transform = CGAffineTransformMakeTranslation(0, 0)
            nightTimePicker.transform = CGAffineTransformMakeTranslation(0, 0)
            morningTimePicker.alpha = 0
        }
        
        if isNightReminderOn {
            nightTimePicker.alpha = 1
        } else {
            nightTimePicker.alpha = 0
        }

        morningTimePicker.onValueChanged = { [unowned self] date in
            LocalNotification.shared.requestDailyMorningRoutine(
                hour: morningTimePicker.hourComponent,
                minute: morningTimePicker.minuteComponent
            )
            UserDefaults.standard.set(date, forKey: K.UD.morningReminderTime)
        }

        nightTimePicker.onValueChanged = { [unowned self] date in
            LocalNotification.shared.requestDailyNightRoutine(
                hour: nightTimePicker.hourComponent,
                minute: nightTimePicker.minuteComponent
            )
            UserDefaults.standard.set(date, forKey: K.UD.nightReminderTime)
        }

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
            
        } else {
            
            UIView.animate(withDuration: 0.2, animations: { [self] in
                nightReminderView.transform = CGAffineTransformMakeTranslation(0, 0)
                nightTimePicker.transform = CGAffineTransformMakeTranslation(0, 0)
                morningTimePicker.alpha = 0
            })
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        morningReminderView.reminderSwitch.isOn = isMorningReminderOn
        morningReminderView.reminderSwitch.addTarget(self, action: #selector(timePickerSwitchOnClick), for: .touchUpInside)
        
        nightReminderView.reminderSwitch.isOn = isNightReminderOn
        nightReminderView.reminderSwitch.addTarget(self, action: #selector(timePickerSwitchOnClick), for: .touchUpInside)
        
    }

}
