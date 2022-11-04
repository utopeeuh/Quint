//
//  ActivityLevelUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 04/11/22.
//

import UIKit

class ActivityLevelUIView: SummaryUIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleImage.image = UIImage(named: "alIcon")
        self.titleLabel.text = "Activity level"
        self.subTitleLabel.text = "Your average activity level is"
        self.bigNumLabel.isHidden = true
        self.bigTitleLabel.text = "Very active"
        self.bigTitleImage.image = UIImage(named: "rocketIcon")
        self.descLabel.text = "It seems like you are have lots of activity. Make sure to reapply your sunscreen every 2 hours!"
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
