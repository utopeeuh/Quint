//
//  OnboardingQuizView.swift
//  Quint
//
//  Created by Vendly on 13/10/22.
//

import UIKit
import SnapKit

@available(iOS 16.0, *)
class SkinTypeView: OnboardingParentView {
    
    private let skinTypeLabel = UILabel()
    public var nextButton = NextButton()
    
    private var buttons: [CollapsableButton] = []
    private var collapsableStack = CollapsableStack()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureComponents() {
        
        skinTypeLabel.text = "What is your skin type?"
        skinTypeLabel.font = .clashGroteskMedium(size: 30)
        skinTypeLabel.textAlignment = .left

        nextButton.setText("Next")
        nextButton.addTarget(self, action: #selector(nextOnClick), for: .touchUpInside)
        
        collapsableStack.append(CollapsableButton(title: "Normal skin", desc: "This skin is neither too dry nor too oily. It has regular texture, no imperfections and a clean, soft appearance, and does not need special care."))
        
        collapsableStack.append(CollapsableButton(title: "Dry skin", desc: "Feeling of tightness and roughness. It may also acquire an ashy gray color, with occurrence of desquamation, itching, redness and small cracks."))
        
        collapsableStack.append(CollapsableButton(title: "Oily skin", desc: "Oily skin has a porous, humid and bright appearance. It is caused by excessive fat production by sebaceous glands."))
        
        collapsableStack.append(CollapsableButton(title: "Combination skin", desc: "Characteristics of both dry and oily skin. The area with more oil is usually the T- zone (forehead, nose, and chin), while the cheeks is normal or dry."))
        
        collapsableStack.buttons.forEach { b in
            b.headerBtn.addTarget(self, action: #selector(onClickExpand), for: .touchUpInside)

        }
        
    }
        
    override func configureLayout() {
        
        addSubview(skinTypeLabel)
        addSubview(collapsableStack)
        addSubview(nextButton)
        
        skinTypeLabel.snp.makeConstraints { make in
            make.centerX.top.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
        }
       
        collapsableStack.snp.makeConstraints { make in
            make.top.equalTo(skinTypeLabel.snp.bottom).offset(32)
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
    
    func getSkinType() -> Int{
        return collapsableStack.selectedIndex
    }
}

@available(iOS 16.0, *)
extension SkinTypeView: CollapsableStackDelegate{
    @objc func onClickExpand(_ sender: UIButton){
        if let collapsable = sender.superview as? CollapsableButton{
            collapsableStack.showView(collapsable)
            nextButton.setEnabled()
        }
    }
}

