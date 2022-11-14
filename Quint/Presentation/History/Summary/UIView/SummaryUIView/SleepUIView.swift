//
//  SleepUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 04/11/22.
//

import UIKit

class SleepUIView: SummaryUIView {
    
    var sleepHour: Float = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setData() {
        var sleepHourCounter: Float = 0.0
        logList.forEach { log in
            sleepHourCounter += Float(log.sleep)
        }
        sleepHour = sleepHourCounter/Float(logList.count)
        if sleepHour > 9.0 {
            imageName = "confusedIcon"
            descriptionText = "You are sleeping more than you should be. You only need 7-9 hours to sleep. Oversleeping may potentially cause health problems."
        }else if sleepHour >= 7.0 && sleepHour <= 9.0{
            imageName = "trumpetIcon"
            descriptionText = "You are on the right track. Sleeping for 7-9 hours will allow your skin to regenerate and heal."
        }else if sleepHour < 7.0 {
            imageName = "confusedIcon"
            descriptionText = "Let your skin have time to regenerate and heal. You need to increase your sleep time to ideally 7-9 hours."
        }
        self.titleImage.image = UIImage(named: "sIcon")
        self.titleLabel.text = "Sleep"
        self.subTitleLabel.text = "Your average time of sleep is"
        self.bigNumLabel.text = "\(sleepHour)"
        self.bigTitleLabel.text = "hours"
        self.bigTitleImage.image = UIImage(named: imageName)
        self.descLabel.text = descriptionText
    }
}
