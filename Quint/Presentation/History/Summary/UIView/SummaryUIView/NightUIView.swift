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
        self.titleImage.image = UIImage(named: "nrIcon")
        self.titleLabel.text = "Night routine"
        self.subTitleLabel.text = "You have completed"
        self.bigNumLabel.text = "24"
        self.bigTitleLabel.text = "routines"
        self.bigTitleImage.image = UIImage(named: "confusedIcon")
        self.descLabel.text = "You slacked off a little bit. We can help you to keep consistent by reminders!"
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
