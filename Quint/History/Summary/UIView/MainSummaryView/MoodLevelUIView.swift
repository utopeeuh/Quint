//
//  MoodLevelUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 04/11/22.
//

import UIKit

class MoodLevelUIView: SummaryUIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleImage.image = UIImage(named: "mlIcon")
        self.titleLabel.text = "Mood level"
        self.subTitleLabel.text = "Your average mood is"
        self.bigNumLabel.isHidden = true
        self.bigTitleLabel.text = "joyful"
        self.bigTitleImage.image = UIImage(named: "joyfulMoodIcon")
        self.descLabel.text = "Wohooo!! Your week has been great and you loved it. Happy you, happy skin!"
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
