//
//  OnboardingQuizView.swift
//  Quint
//
//  Created by Vendly on 13/10/22.
//

import UIKit

class SkinTypeView: UIView {
    
//    public let backButton = BackButton()
//    private let progressBar = UIProgressView()
    private let skinTypeLabel = UILabel()
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

//        progressBar.trackTintColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
//        progressBar.progressTintColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
//        progressBar.setProgress(0.16, animated: true)
//        progressBar.layer.cornerRadius = 4
//        progressBar.clipsToBounds = true
        
        skinTypeLabel.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
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
            stackView.addArrangedSubview(skinTypeBox)
            textHeight = skinTypeBox.labelContent.requiredHeight
        }
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .equalSpacing
        stackView.layoutSubviews()
        
        nextButton.setText("Next")
        
    }
        
    func configureLayout() {
        
//        addSubview(backButton)
//        addSubview(progressBar)
        addSubview(skinTypeLabel)
        addSubview(stackView)
        addSubview(nextButton)
        
//        backButton.snp.makeConstraints { make in
//            make.width.height.equalTo(24)
//        }
//
//        progressBar.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.right.equalTo(backButton).offset(20)
//            make.width.equalTo(300)
//            make.height.equalTo(7)
//            make.top.equalToSuperview().offset(65)
//        }
        
        skinTypeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
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
            make.bottom.equalToSuperview().offset(-62)
            make.width.equalToSuperview().offset(-40)
        }
        
    }
    
}
