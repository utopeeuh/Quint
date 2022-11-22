//
//  ActivityView.swift
//  Quint
//
//  Created by Vendly on 25/10/22.
//

import UIKit
import SnapKit

@available(iOS 16.0, *)
class ActivityView: CustomLogView {
    
    private var dateLabel = UILabel()
    private var routineLabel = UILabel()
    
    private var morningCell = CustomLogView()
    private var nightCell = CustomLogView()
    private var sleepCell = CustomLogView()
    private var moodCell = CustomLogView()
    private var activityLevelCell = CustomLogView()
    private var skinCondCell = CustomLogView()
    var logModel: LogModel?
    
    private var logLabel = UILabel()
    public var editButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureComponents() {
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM yyyy"

        let exactlyCurrentTime: Date = Date()
        print(dateFormatterPrint.string(from: exactlyCurrentTime))
        dateLabel.text = dateFormatterPrint.string(from: exactlyCurrentTime)
        dateLabel.textColor = K.Color.blackQuint
        dateLabel.font = .clashGroteskMedium(size: 24)
        dateLabel.textAlignment = .left
        
        routineLabel.text = "Routine"
        routineLabel.textColor = K.Color.blackQuint
        routineLabel.font = .clashGroteskMedium(size: 20)
        
        logLabel.text = "Log"
        logLabel.textColor = K.Color.blackQuint
        logLabel.font = .clashGroteskMedium(size: 20)
        
        editButton.isEnabled = true
        editButton.setTitle("Edit entry", for: .normal)
        editButton.titleLabel?.font = .interMedium(size: 13)
        editButton.setTitleColor(K.Color.greyDarkQuint, for: .normal)
        editButton.backgroundColor = K.Color.disableBgBtnQuint
        editButton.layer.cornerRadius = 15
        
        morningCell.setImage(UIImage(named: "morning_grey_icon"))
        morningCell.setBackground(K.Color.disableBgBtnQuint)
        morningCell.setTitle("Morning", K.Color.greyQuint)

        nightCell.setImage(UIImage(named: "night_icon"))
        nightCell.setBackground(K.Color.disableBgBtnQuint)
        nightCell.setTitle("Night", K.Color.greyQuint)
        
        sleepCell.setImage(UIImage(named: "sleep_icon"))
        sleepCell.setTitle("Sleep time", K.Color.greyQuint)
       
        moodCell.setTitle("Mood level", K.Color.greyQuint)
        
        activityLevelCell.setTitle("Activity level", K.Color.greyQuint)
        
        skinCondCell.setTitle("Skin condition", K.Color.greyQuint)
        
        
    }
        
    override func configureLayout() {

        multipleSubviews(view: dateLabel, routineLabel,
                               logLabel, editButton,
                               morningCell, nightCell,
                               sleepCell, moodCell,
                               activityLevelCell, skinCondCell)
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(32)
            make.width.equalToSuperview().offset(-40)
        }
        
        routineLabel.snp.makeConstraints { make in
            make.centerX.width.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(40)
        }
        
        morningCell.snp.makeConstraints { make in
            make.top.equalTo(routineLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.width.equalTo(169)
            make.height.equalTo(78)
        }
        
        nightCell.snp.makeConstraints { make in
            make.top.equalTo(morningCell)
            make.leading.equalTo(morningCell.snp.trailing).offset(12)
            make.width.height.equalTo(morningCell)
        }
        
        logLabel.snp.makeConstraints { make in
            make.top.equalTo(morningCell.snp.bottom).offset(57)
            make.leading.equalTo(20)
        }
        
        sleepCell.snp.makeConstraints { make in
            make.top.equalTo(logLabel.snp.bottom).offset(20)
            make.leading.equalTo(morningCell)
            make.width.height.equalTo(morningCell)
        }
        
        moodCell.snp.makeConstraints { make in
            make.top.equalTo(sleepCell)
            make.leading.equalTo(sleepCell.snp.trailing).offset(12)
            make.width.height.equalTo(morningCell)
        }
        
        activityLevelCell.snp.makeConstraints { make in
            make.top.equalTo(sleepCell.snp.bottom).offset(12)
            make.leading.equalTo(morningCell)
            make.width.height.equalTo(morningCell)
        }
        
        skinCondCell.snp.makeConstraints { make in
            make.top.equalTo(activityLevelCell)
            make.leading.equalTo(activityLevelCell.snp.trailing).offset(12)
            make.width.height.equalTo(morningCell)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(logLabel)
            make.trailing.equalTo(-20)
            make.width.equalTo(81)
            make.height.equalTo(28)
        }
        
    }
    
    func refreshData(logModel: LogModel){
        self.logModel = logModel
        
        sleepCell.setDesc("\(String(describing: logModel.sleep)) hours", K.Color.blackQuint)
        
        if logModel.isDayDone == true {
            morningCell.setBackground(K.Color.whiteQuint)
            morningCell.setImage(UIImage(named: "morning_color_icon"))
            morningCell.setDesc("Done", K.Color.blackQuint)
        }else {
            morningCell.setDesc("Not yet", K.Color.greyQuint)
        }
        
        if logModel.isNightDone == true {
            nightCell.setBackground(K.Color.whiteQuint)
            nightCell.setImage(UIImage(named: "night_color_icon"))
            nightCell.setDesc("Done", K.Color.blackQuint)
        }else {
            nightCell.setDesc("Not yet", K.Color.greyQuint)
        }
        
        switch logModel.moodId {
            case 1:
                moodCell.setImage(UIImage(named: "stressed_mood_icon"))
                moodCell.setDesc("Stressed", K.Color.blackQuint)
            case 2:
                moodCell.setImage(UIImage(named: "sad_mood_icon"))
                moodCell.setDesc("Sad", K.Color.blackQuint)
            case 3:
                moodCell.setImage(UIImage(named: "neutral_mood_icon"))
                moodCell.setDesc("Normal", K.Color.blackQuint)
            case 4:
                moodCell.setImage(UIImage(named: "happy_mood_icon"))
                moodCell.setDesc("Happy", K.Color.blackQuint)
            case 5:
                moodCell.setImage(UIImage(named: "joyful_mood_icon"))
                moodCell.setDesc("Joyful", K.Color.blackQuint)
            default:
                print("error")
        }
        
        switch logModel.activityLevel {
            case 1:
                activityLevelCell.setImage(UIImage(named: "sedentaryIcon"))
                activityLevelCell.setDesc("Sedentary", K.Color.blackQuint)
            case 2:
                activityLevelCell.setImage(UIImage(named: "activeIcon"))
                activityLevelCell.setDesc("Active", K.Color.blackQuint)
            case 3:
                activityLevelCell.setImage(UIImage(named: "veryActiveIcon"))
                activityLevelCell.setDesc("Very active", K.Color.blackQuint)
            default:
                print("error")
        }
        
        if logModel.isBetter == true {
            skinCondCell.setImage(UIImage(named: "skin_cond_icon"))
            skinCondCell.setDesc("Better", K.Color.blackQuint)
        }else {
            skinCondCell.setImage(UIImage(named: "worsenIcon"))
            skinCondCell.setDesc("Worsen", K.Color.blackQuint)
        }
        
        
        
    }
    
}
