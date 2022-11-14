//
//  ActivityLevelUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 04/11/22.
//

import UIKit

class ActivityLevelUIView: SummaryUIView {
    
    var veryActiveCounter = 0
    var activeCounter = 0
    var sedentaryCounter = 0 
    var activityLevel: String!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setData() {
        logList.forEach { log in
            switch log.activityLevel {
            case 1:
                veryActiveCounter += 1
            case 2:
                activeCounter += 1
            case 3:
                sedentaryCounter += 1
            default:
                print("error")
            }
        }
        if veryActiveCounter > activeCounter && veryActiveCounter > sedentaryCounter {
            activityLevel = "Very active"
            imageName = "personLiftingWeightsIcon"
            descriptionText = "Use moisturizer to keep your skin hydrated. Go for a little walk once in a while with sunscreen applied."
        }else if activeCounter > veryActiveCounter && activeCounter > sedentaryCounter {
            activityLevel = "Active"
            imageName = "personRunningIcon"
            descriptionText = "You are getting active lately. Sunscreen is recommended if you go out a lot. Reapply sunscreen every 2 hours if needed."
        }else if sedentaryCounter > veryActiveCounter && sedentaryCounter > activeCounter{
            activityLevel = "Sedentary"
            imageName = "monkeyIcon"
            descriptionText = "This month has been really active for you.  Be sure to reapply your sunscreen every 2 hours and wash your face thoroughly after the activity."
        }
        self.titleImage.image = UIImage(named: "alIcon")
        self.titleLabel.text = "Activity level"
        self.subTitleLabel.text = "Your average activity level is"
        self.bigNumLabel.isHidden = true
        self.bigTitleLabel.text = activityLevel
        self.bigTitleImage.image = UIImage(named: imageName)
        self.descLabel.text = descriptionText
    }

}
