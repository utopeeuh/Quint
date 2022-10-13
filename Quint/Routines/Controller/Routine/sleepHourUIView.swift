//
//  sleepHourUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 13/10/22.
//

import UIKit

class sleepHourUIView: UIView {
    
    lazy var hStackSleepHour: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 85
        return stackView
    }()
    
    private lazy var vStackViewSleepHour: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8.0
        self.isUserInteractionEnabled = true
        configureComponents()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureComponents()
        configureLayout()
        
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
    
    var countNum: Int = 8
    
    
    private var numLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(48)
        label.textColor = K.Color.greenQuint
        return label
    }()
    
    private var hoursLabel: UILabel = {
        let label = UILabel()
        label.text = "Hours"
        label.textColor = .black
        label.font = label.font.withSize(20)
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
            hStackSleepHour.spacing = 71
        }else {
            numLabel.text = "\(countNum)"
            hStackSleepHour.spacing = 85
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
            hStackSleepHour.spacing = 71
        }else {
            numLabel.text = "\(countNum)"
            hStackSleepHour.spacing = 85
        }
        
    }
    
    func configureComponents() {
        hStackSleepHour.addArrangedSubview(minBtn)
        minBtn.addTarget(self, action: #selector(minHandler), for: .touchUpInside)
        
        vStackViewSleepHour.addArrangedSubview(numLabel)
        numLabel.text = String(countNum)
        if countNum == 1 {
            minBtn.isEnabled = false
        }
        
        if countNum >= 10 {
            numLabel.text = "\(countNum)+"
            plusBtn.isEnabled = false
        }
        
        vStackViewSleepHour.addArrangedSubview(hoursLabel)
        
        hStackSleepHour.addArrangedSubview(vStackViewSleepHour)
        
        hStackSleepHour.addArrangedSubview(plusBtn)
        plusBtn.addTarget(self, action: #selector(plusHandler), for: .touchUpInside)
    }
    
    
    func configureLayout() {
        self.addSubview(hStackSleepHour)
        
        minBtn.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaInsets).offset(25)
            make.top.equalTo(self.safeAreaInsets).offset(30)
        }
        
        numLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaInsets).offset(-25)
        }
        
        plusBtn.snp.makeConstraints { make in
            make.right.equalTo(self.safeAreaInsets).offset(-25)
            make.top.equalTo(self.safeAreaInsets).offset(30)
        }
        
        
    }

}
