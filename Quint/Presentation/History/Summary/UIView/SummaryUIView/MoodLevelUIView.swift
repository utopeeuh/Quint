//
//  MoodLevelUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 04/11/22.
//

import UIKit

class MoodLevelUIView: SummaryUIView {
    
    var joyfulCounter = 0
    var happyCounter = 0
    var normalCounter = 0
    var sadCounter = 0
    var stressedCounter = 0
    var moodLevel: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setData() {
        logList.forEach { log in
            switch log.moodId {
            case 1:
                joyfulCounter += 1
            case 2:
                happyCounter += 1
            case 3:
                normalCounter += 1
            case 4:
                sadCounter += 1
            case 5:
                stressedCounter += 1
            default:
                print("error")
            }
        }
        
        if joyfulCounter > happyCounter && joyfulCounter > normalCounter && joyfulCounter > sadCounter && joyfulCounter > stressedCounter {
            moodLevel = "Joyful"
            imageName = "trumpetIcon"
            descriptionText = "Yippeee!! It's a joyful week for you and your skin. Keep doing the things that make you happy. Do your hobbies, hang out with friends or family, and spend money wisely."
        }else if happyCounter > joyfulCounter && happyCounter > normalCounter && happyCounter > sadCounter && happyCounter > stressedCounter {
            moodLevel = "Happy"
            imageName = "smileIcon"
            descriptionText = "Wohooo!! Your week has been great and you loved it. Happy you, happy skin!"
        }else if normalCounter > joyfulCounter && normalCounter > happyCounter && normalCounter > sadCounter && normalCounter > stressedCounter {
            moodLevel = "Normal"
            imageName = "raisedEyebrowIcon"
            descriptionText = "Nothing significant happened throughout the month. It's your typical month. Cheer Up! Your skin loves when you do the things you love."
        }else if sadCounter > joyfulCounter && sadCounter > normalCounter && sadCounter > happyCounter && sadCounter > stressedCounter {
            moodLevel = "Sad"
            imageName = "confusedIcon"
            descriptionText = "Ohh nooo. What happened? You should probably talk to someone if you need help. Crying might also help, but please cry before using skincare."
        }else if stressedCounter > joyfulCounter && stressedCounter > normalCounter && stressedCounter > sadCounter && stressedCounter > happyCounter {
            moodLevel = "Stressed"
            imageName = "steamIcon"
            descriptionText = "You Rock!! Lots of pressures and stressful moments this month but you survived. Be sure to do your morning and night routines even when it gets hard."
        }
        
        self.titleImage.image = UIImage(named: "mlIcon")
        self.titleLabel.text = "Mood level"
        self.subTitleLabel.text = "Your average mood is"
        self.bigNumLabel.isHidden = true
        self.bigTitleLabel.text = moodLevel
        self.bigTitleImage.image = UIImage(named: imageName)
        self.descLabel.text = descriptionText
    }
}
