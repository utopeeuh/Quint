//
//  NavigationBarUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 17/11/22.
//

import UIKit

class NavigationBarUIView: UIView {
    
    var lineWhiteRoutine = UIView()
    var lineWhiteHistory = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = K.Color.greenQuint
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    var routineButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .interSemiBold(size: 13)
        button.setTitle("Routine", for: .normal)
        button.setImage(UIImage(named: "calendarMonth"), for: .normal)
        return button
    }()
    
    var historyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .interSemiBold(size: 13)
        button.setTitle("History", for: .normal)
        button.setImage(UIImage(named: "receipt"), for: .normal)
        return button
    }()
    
    override func configureComponents() {
        self.addSubview(horizontalStack)
        self.addSubview(lineWhiteRoutine)
        self.addSubview(lineWhiteHistory)
        
        lineWhiteHistory.backgroundColor = K.Color.whiteQuint
        lineWhiteRoutine.backgroundColor = K.Color.whiteQuint
        
        horizontalStack.addArrangedSubview(routineButton)
        horizontalStack.addArrangedSubview(historyButton)
    }
    
    override func configureLayout() {
        horizontalStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        
        lineWhiteRoutine.snp.makeConstraints { make in
            make.width.equalTo(routineButton.snp.width)
            make.left.bottom.equalToSuperview()
            make.height.equalTo(3)
        }
        
        lineWhiteHistory.snp.makeConstraints { make in
            make.width.equalTo(routineButton.snp.width)
            make.right.bottom.equalToSuperview()
            make.height.equalTo(3)
        }
        
        routineButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.width.equalTo(192)
            make.height.equalToSuperview()
        }
        
        historyButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.width.equalTo(routineButton.snp.width)
            make.height.equalToSuperview()
        }
        
        routineButton.alignVertical()
        historyButton.alignVertical()
    }

}
