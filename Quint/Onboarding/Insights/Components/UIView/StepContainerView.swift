//
//  StepsListView.swift
//  Quint
//
//  Created by Vendly on 20/10/22.
//

import UIKit
import SnapKit
import CoreData

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

    override func configureComponents() {
        
        layer.cornerRadius = 10
        backgroundColor = K.Color.whiteQuint
        
        titleLabel.text = "All day essentials"
        titleLabel.font = .clashGroteskMedium(size: 24)
        titleLabel.textColor = K.Color.blackQuint
    }
    
    override func configureLayout() {

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
            make.width.equalToSuperview().offset(-48)
        }
    }
    
    func setSteps(categoryIds: [Int]){
        
        let categoryList : [CategoryModel] = DataHelper.shared.fetchCategoryListById(categoryIds: categoryIds)
        
        for i in 0..<categoryList.count {
            
            let view = CustomCellView()
            
            view.numberLabel.text = String(describing: i+1)
            view.stepsLabel.text = categoryList[i].title
            
            let currIsDay = categoryList[i].isDay as! Bool
            let currIsNight = categoryList[i].isNight as! Bool
            
            if currIsDay && !currIsNight {
                view.setAsMorning()
            } else if currIsNight && !currIsDay{
                view.setAsNight()
            }
            
            stepViews.append(view)
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
