//
//  SleepHourUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 13/10/22.
//

import Foundation
import UIKit
import SnapKit

class SleepHourUIView: UIView {

    let height : CGFloat = 134
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8.0
        self.isUserInteractionEnabled = true
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private var minBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "iconMin"), for: .normal)
        return button
    }()
    
    private var plusBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "iconPlus"), for: .normal)
        return button
    }()
    
    private var countNum: Int = 8
    
    
    private var numLabel: UILabel = {
        let label = UILabel()
        label.font = .clashGroteskMedium(size: 48)
        label.textColor = K.Color.greenQuint
        return label
    }()
    
    private var hoursLabel: UILabel = {
        let label = UILabel()
        label.text = "Hours"
        label.textColor = .black
        label.font = .interMedium(size: 20)
        return label
    }()
    
    @objc func minHandler() {
        plusBtn.isEnabled = true
        if countNum > 1 {
            countNum = countNum - 1
            if countNum == 1 {
                minBtn.isEnabled = false
           }
        }
        
        
        if countNum == 10 {
            numLabel.text = "\(countNum)+"
        }else {
            numLabel.text = "\(countNum)"
        }

    }
    
    @objc func plusHandler() {
        minBtn.isEnabled = true
        if countNum < 10 {
            countNum = countNum + 1
            if countNum == 10 {
                plusBtn.isEnabled = false
            }
        }
        
        if countNum == 10 {
            numLabel.text = "\(countNum)+"
        }else {
            numLabel.text = "\(countNum)"
        }
        
    }
    
    override func configureComponents() {
        minBtn.addTarget(self, action: #selector(minHandler), for: .touchUpInside)
        
        numLabel.text = String(countNum)
        if countNum == 1 {
            minBtn.isEnabled = false
        }
        
        if countNum >= 10 {
            numLabel.text = "\(countNum)+"
            plusBtn.isEnabled = false
        }
        
        plusBtn.addTarget(self, action: #selector(plusHandler), for: .touchUpInside)
    }
    
    
    override func configureLayout() {
        multipleSubviews(view: hoursLabel, numLabel, plusBtn, minBtn)
        
        numLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
        
        hoursLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-32)
        }
        
        minBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
        }
        
        plusBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.centerY.equalToSuperview()
        }
        
    }
    
    func getSleepNumber() -> Int {
        return countNum
    }

}
