//
//  SkinConditionView.swift
//  Quint
//
//  Created by Vendly on 15/10/22.
//

import UIKit

class SkinConditionView: UIView {
    
    private let skinConditionLabel = UILabel()
    var stackView = UIStackView()
    var boxes: [K.Box] = []
    public let nextButton = NextButton()
    var textHeight: CGFloat = 0
    
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
        
        skinConditionLabel.numberOfLines = 2
        skinConditionLabel.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        skinConditionLabel.text = "Do you have a sensitive skin condition?"
        skinConditionLabel.font = .clashGroteskMedium(size: 30)
        skinConditionLabel.textAlignment = .left
        
        var yes = K.Box()
        yes.title = "Yes"
        yes.desc = "Sensitive skin is more prone to react to stimuli to which normal skin has no reaction. It is a fragile skin, usually accompanied by feelings of discomfort, such as heat, tightness, redness or itching."
        boxes.append(yes)
        
        var no = K.Box()
        no.title = "No"
        no.desc = ""
        boxes.append(no)
        
        for b in boxes {
            let skinTypeBox = CustomBoxView(title: b.title!, desc: b.desc!)
            stackView.addArrangedSubview(skinTypeBox)
            textHeight = skinTypeBox.labelContent.requiredHeight
        }
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .equalSpacing
        stackView.layoutSubviews()
        
    }
    
    func configureLayout() {
        
        addSubview(skinConditionLabel)
        addSubview(stackView)
        addSubview(nextButton)
        
        skinConditionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
            make.width.equalToSuperview().offset(-40)
        }
       
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(skinConditionLabel.snp.bottom).offset(32)
            make.width.equalToSuperview()
            make.height.equalTo((90 + Int(textHeight)) * boxes.count)
            
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-62)
            make.width.equalToSuperview().offset(-40)
        }
        
    }
    
}
