//
//  SleepUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 04/11/22.
//

import UIKit

class SleepUIView: SummaryUIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleImage.image = UIImage(named: "sIcon")
        self.titleLabel.text = "Sleep"
        self.subTitleLabel.text = "Your average time of sleep is"
        self.bigNumLabel.text = "8.3"
        self.bigTitleLabel.text = "hours"
        self.bigTitleImage.image = UIImage(named: "loveEyeIcon")
        self.descLabel.text = "You are on the right track, Sleeping between these ranges is enough for your skin to repair itself."
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
