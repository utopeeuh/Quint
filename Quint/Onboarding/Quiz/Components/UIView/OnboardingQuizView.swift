//
//  OnboardingQuizView.swift
//  Quint
//
//  Created by Vendly on 13/10/22.
//

import UIKit

class OnboardingQuizView: UIView {
    
    public let backButton = BackButton()
    private let progressBar = UIProgressView()
    private let skinTypeLabel = UILabel()
    private let skinTypeBox = CustomBoxView()
    public let nextButton = NextButton()
    
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

            progressBar.trackTintColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
            progressBar.progressTintColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
            progressBar.setProgress(0.16, animated: true)
            progressBar.layer.cornerRadius = 4
            progressBar.clipsToBounds = true
            
            skinTypeLabel.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
            skinTypeLabel.text = "What is your skin type?"
            skinTypeLabel.font = .clashGroteskMedium(size: 30)
            skinTypeLabel.textAlignment = .left
            
            skinTypeBox.labelContainer.text = "Normal Skin"
            skinTypeBox.labelContent.text = "This skin is neither too dry nor too oily. It has regular texture, no imperfections and a clean, soft appearance, and does not need special care."
            
        }
        
        func configureLayout() {
            
            addSubview(backButton)
            addSubview(progressBar)
            addSubview(skinTypeLabel)
            addSubview(skinTypeBox)
            addSubview(nextButton)
            
            backButton.snp.makeConstraints { make in
                make.width.height.equalTo(24)
            }
            
            progressBar.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.right.equalTo(backButton).offset(20)
                make.width.equalTo(300)
                make.height.equalTo(7)
                make.top.equalToSuperview().offset(65)
            }
            
            skinTypeLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(progressBar.snp.bottom).offset(70)
                make.width.equalToSuperview().offset(-40)
            }
           
            skinTypeBox.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(skinTypeLabel.snp.bottom).offset(32)
                make.height.equalTo(52)
                make.width.equalToSuperview().offset(-40)
            }
            
            nextButton.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.height.equalTo(50)
                make.bottom.equalToSuperview().offset(-62)
                make.width.equalToSuperview().offset(-40)
            }
            
        }
    
}
