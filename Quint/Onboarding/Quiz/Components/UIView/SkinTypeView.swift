//
//  OnboardingQuizView.swift
//  Quint
//
//  Created by Vendly on 13/10/22.
//

import UIKit
import SnapKit

class SkinTypeView: OnboardingParentView {
    
    private let skinTypeLabel = UILabel()
    var stackView = UIStackView()
    var boxes: [K.Box] = []
    var customBox: CustomBoxView!
    public let nextButton = NextButton()
    var textHeight: CGFloat = 0
    var tapGesture = UITapGestureRecognizer()
    
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
        
        skinTypeLabel.text = "What is your skin type?"
        skinTypeLabel.font = .clashGroteskMedium(size: 30)
        skinTypeLabel.textAlignment = .left
        
        var normalSkin = K.Box()
        normalSkin.title = "Normal skin"
        normalSkin.desc = "This skin is neither too dry nor too oily. It has regular texture, no imperfections and a clean, soft appearance, and does not need special care."
        boxes.append(normalSkin)
        
        var drySkin = K.Box()
        drySkin.title = "Dry skin"
        drySkin.desc = "Feeling of tightness and roughness. It may also acquire an ashy gray color, with occurrence of desquamation, itching, redness and small cracks."
        boxes.append(drySkin)
        
        var oilySkin = K.Box()
        oilySkin.title = "Oily skin"
        oilySkin.desc = "Oily skin has a porous, humid and bright appearance. It is caused by excessive fat production by sebaceous glands."
        boxes.append(oilySkin)
        
        var combinationSkin = K.Box()
        combinationSkin.title = "Combination skin"
        combinationSkin.desc = "Characteristics of both dry and oily skin. The area with more oil is usually the T- zone (forehead, nose, and chin), while the cheeks is normal or dry."
        boxes.append(combinationSkin)
        
        for b in boxes {
            let skinTypeBox = CustomBoxView(title: b.title!, desc: b.desc!)
            textHeight = skinTypeBox.labelContent.requiredHeight
            
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(singleTap))
            tapGesture.numberOfTapsRequired = 1
            
            stackView.addArrangedSubview(skinTypeBox)
        }
        
//        print(textHeight)
        
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .equalSpacing
        stackView.layoutSubviews()
        
        nextButton.setText("Next")
        nextButton.addTarget(self, action: #selector(nextOnClick), for: .touchUpInside)
        
    }
        
    func configureLayout() {
        
        addSubview(skinTypeLabel)
        addSubview(stackView)
        addSubview(nextButton)
        
        skinTypeLabel.snp.makeConstraints { make in
            make.centerX.top.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
        }
       
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(skinTypeLabel.snp.bottom).offset(32)
            make.width.equalToSuperview()
            make.height.equalTo((51 + Int(textHeight)) * boxes.count)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalToSuperview().offset(-40)
        }
        
    }
    
    @objc func singleTap() {

        customBox.containerBox.backgroundColor = K.Color.whiteQuint
        customBox.containerBox.layer.cornerRadius = 8

        customBox.labelContainer.textColor = K.Color.blackQuint
        customBox.labelContainer.font = .interMedium(size: 16)
        
    }
    
}

