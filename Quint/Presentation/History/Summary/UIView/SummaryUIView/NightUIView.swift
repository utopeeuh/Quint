//
//  NightUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 04/11/22.
//

import UIKit

class NightUIView: SummaryUIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setData() {
        var nightRoutineCounter = 0
        var denom = 1
        
        if Calendar.current.startOfMonth(logList.first?.date ?? Date.now) == Calendar.current.startOfMonth(Date.now) {
            denom = Int(Calendar.current.component(.day, from: Date.now))
        }else {
            denom = Int(Calendar.current.component(.day, from: Calendar.current.endOfMonth(logList.first!.date)))
        }
        
        logLoop: for log in logList {
            
            if logList.first == nil {
                break logLoop
            }
            
            if log.isDayDone == true {
                nightRoutineCounter += 1
            }
        }
        
        let parameterPersentage = Float(nightRoutineCounter/denom*100)
        
        if parameterPersentage > 90.0 {
            descriptionText = "That’s a really good number! Keep it up!"
            imageName = "trumpetIcon"
        }else if parameterPersentage > 75.0 && parameterPersentage <= 90.0 {
            descriptionText = "Doing great! but you need to be more consistent to get the best out of your skincare routines."
            imageName = "smileIcon"
        }else if parameterPersentage > 65.0 && parameterPersentage <= 75.0 {
            descriptionText = "You slacked off a bit. We can help you with reminders. Go to profile to check it out!"
            imageName = "raisedEyebrowIcon"
        }else if parameterPersentage >= 30.0 && parameterPersentage <= 65.0 {
            descriptionText = "Ohhh no, please don't let all your skincare be wasted. Let us help you with reminders. Go to profile to check it out!"
            imageName = "confusedIcon"
        }else {
            descriptionText = "Go go go! We believe you could do it. If you need any help, check reminders on profile section."
            imageName = "steamIcon"
        }
        
        self.titleImage.image = UIImage(named: "nrIcon")
        self.titleLabel.text = "Night routine"
        self.subTitleLabel.text = "You have completed"
        self.bigNumLabel.text = "\(nightRoutineCounter)"
        self.bigTitleLabel.text = "routines"
        self.descLabel.text = descriptionText
        self.bigTitleImage.image = UIImage(named: imageName)
    }
    

}
