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
        stackView.spacing = 20
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
    
    private var numLabel: UILabel = {
        let label = UILabel()
        label.text = "8"
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
    
    func configureComponents() {
        hStackSleepHour.addArrangedSubview(minBtn)
        
        vStackViewSleepHour.addArrangedSubview(numLabel)
        vStackViewSleepHour.addArrangedSubview(hoursLabel)
        
        hStackSleepHour.addArrangedSubview(vStackViewSleepHour)
        
        hStackSleepHour.addArrangedSubview(plusBtn)
    }
    
    func configureLayout() {
        self.addSubview(hStackSleepHour)
        
        minBtn.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaInsets).offset(25)
            make.top.equalTo(self.safeAreaInsets).offset(40)
        }
        
        numLabel.snp.makeConstraints { make in
            make.left.equalTo(minBtn.snp.right).offset(95)
            make.top.equalTo(self.safeAreaInsets).offset(-25)
        }
        
        
        plusBtn.snp.makeConstraints { make in
            make.right.equalTo(self.safeAreaInsets).offset(-25)
        }
        
        
    }

}
