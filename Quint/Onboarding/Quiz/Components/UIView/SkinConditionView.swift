//
//  SkinConditionView.swift
//  Quint
//
//  Created by Vendly on 15/10/22.
//

import UIKit
import SnapKit

class SkinConditionView: OnboardingParentView, CollapsableStackDelegate {
    
    private let skinConditionLabel = UILabel()
    
    private var collapsableStack = CollapsableStack()
    
    public let nextButton = NextButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureComponents() {
        
        skinConditionLabel.numberOfLines = 2
        skinConditionLabel.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        skinConditionLabel.text = "Do you have a sensitive skin condition?"
        skinConditionLabel.font = .clashGroteskMedium(size: 30)
        skinConditionLabel.textAlignment = .left
        
        collapsableStack.append(CollapsableButton(title: "Yes", desc: "Sensitive skin is more prone to react to stimuli to which normal skin has no reaction. It is a fragile skin, usually accompanied by feelings of discomfort, such as heat, tightness, redness or itching."))
        
        collapsableStack.append(CollapsableButton(title: "No", desc: ""))
        
        collapsableStack.buttons.forEach { b in
            b.headerBtn.addTarget(self, action: #selector(onClickExpand), for: .touchUpInside)
        }
        
        nextButton.setText("Next")
        nextButton.addTarget(self, action: #selector(nextOnClick), for: .touchUpInside)
    }
    
    override func configureLayout() {
        
        addSubview(skinConditionLabel)
        addSubview(collapsableStack)
        addSubview(nextButton)
        
        skinConditionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
        }
       
        collapsableStack.snp.makeConstraints { make in
            make.top.equalTo(skinConditionLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(collapsableStack.getHeight())
            make.width.equalToSuperview().offset(-40)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalToSuperview().offset(-40)
        }
        
    }
    
    func onClickExpand(_ sender: UIButton) {
        if let collapsable = sender.superview as? CollapsableButton{
            collapsableStack.showView(collapsable)
            nextButton.setEnabled()
        }
    }
}
