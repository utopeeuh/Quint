//
//  MorningUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 04/11/22.
//

import UIKit

class MorningUIView: SummaryUIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleImage.image = UIImage(named: "mrIcon")
        self.titleLabel.text = "Morning routine"
        self.subTitleLabel.text = "You have completed"
        self.bigNumLabel.text = "48"
        self.bigTitleLabel.text = "routines"
        self.bigTitleImage.image = UIImage(named: "trumpetIcon")
        self.descLabel.text = "That’s a really good number! Keep it up!"
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
