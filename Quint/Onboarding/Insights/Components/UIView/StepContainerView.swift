//
//  StepsListView.swift
//  Quint
//
//  Created by Vendly on 20/10/22.
//

import UIKit
import SnapKit

class StepContainerView: UIView {
    
    private var stackView = UIStackView()
    private var titleLabel = UILabel()
    private var stepViews: [CustomCellView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        configureComponents()
        configureLayout()
    }

    func configureComponents() {
        
        layer.cornerRadius = 10
        backgroundColor = K.Color.whiteQuint
        
        titleLabel.text = "All day essentials"
        titleLabel.font = .clashGroteskMedium(size: 24)
        titleLabel.textColor = K.Color.blackQuint
        
        for step in 0..<K.Category.skincareSteps.count {
            
            let view = CustomCellView()
            let essential = K.Category.skincareSteps[step]
            
            view.numberLabel.text = String.init(format: "%d", step+1)
            view.stepsLabel.text = essential.title
            
            if essential.partOfDay == .night {
                view.setAsNight()
            } else if essential.partOfDay == .morning {
                view.setAsMorning()
            }
            
            stepViews.append(view)
        }
        
    }
    
    func configureLayout() {

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
            make.width.equalToSuperview().offset(-48)
        }
        
        stepViews.forEach {
            addSubview($0)
        }
        
        for i in 0..<stepViews.count {
            
            let stepView = stepViews[i]
            
            let isFirstStep = i == 0
            let isLastStep = i == stepViews.count-1
            
            stepView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().offset(-40)
                make.height.equalTo(56)
                
                if isFirstStep {
                    make.top.equalTo(titleLabel.snp.bottom).offset(16)
                } else {
                    make.top.equalTo(stepViews[i-1].snp.bottom).offset(12)
                }
                
                if isLastStep {
                    make.bottom.equalToSuperview().offset(-30)
                }
            }
            
        }
        
    }
    
}
