//
//  ResultTypeView.swift
//  Quint
//
//  Created by Vendly on 17/10/22.
//

import UIKit
import SnapKit
import SwiftUI
import CoreData

class ResultTypeView: UIView {

    private let titleLabel = TitleLabel()
    private let resultLabel = ResultLabel()
    private let descriptionLabel = DescriptionLabel()
    private let backgroundImage = UIImageView()
    private var textHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureComponents() {
        
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 36
        self.layer.shadowOffset = CGSize(width: 0, height: 16)
        self.layer.shadowColor = K.Color.shadowQuint.cgColor
        self.layer.cornerRadius = 10
        
//        backgroundImage.image = UIImage(named: "face_3_logo")
//        backgroundImage.frame = bounds
//        backgroundImage.layer.cornerRadius = 0
//        backgroundImage.layer.compositingFilter = "overlayBlendMode"
        
        titleLabel.text = "SKIN TYPE"
        titleLabel.textColor = K.Color.greenSkinProblemQuint
        titleLabel.sizeToFit()
        
        descriptionLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 88, height: 0)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
    }
    
    override func configureLayout() {
        
        multipleSubviews(view: titleLabel,
                               resultLabel,
                               descriptionLabel)
        
//        backgroundImage.snp.makeConstraints { make in
//            make.width.height.equalTo(250)
//            make.leading.equalTo(150)
//        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(28)
            make.width.equalToSuperview().offset(-48)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.width.equalToSuperview().offset(-48)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
            make.top.equalTo(resultLabel.snp.bottom).offset(10)
        }
        
    }
    
    func setType(typeId: Int){
        //fetch type
        let skinType = SkinTypesRepository.shared.fetchSkinType(id: typeId+1)
        
        //set text here
        resultLabel.text = skinType.title
        resultLabel.sizeToFit()
        descriptionLabel.text = skinType.desc
        descriptionLabel.sizeToFit()
        
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: titleLabel.requiredHeight + resultLabel.requiredHeight + descriptionLabel.requiredHeight + 74)
        self.applyGradient(colours: [K.Color.greenLightQuint, K.Color.greenQuint], locations: [0,1], radius: 8)
    }
}
