//
//  ResultTypeView.swift
//  Quint
//
//  Created by Vendly on 17/10/22.
//

import UIKit
import SnapKit
import SwiftUI

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
    
    func configureUI(){
        configureComponents()
        configureLayout()
    }
    
    func configureComponents() {
        
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 36
        self.layer.shadowOffset = CGSize(width: 0, height: 16)
        self.layer.shadowColor = K.Color.shadowQuint.cgColor
        self.layer.cornerRadius = 10
        
//        backgroundImage.image = UIImage(named: "face_3_logo")
//        backgroundImage.frame = bounds
//        backgroundImage.layer.cornerRadius = 0
//        backgroundImage.layer.compositingFilter = "overlayBlendMode"
        
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 208)
        self.applyGradient(colours: [K.Color.greenLightQuint, K.Color.greenQuint], locations: [0,1], radius: 8)
        
        titleLabel.text = "SKIN TYPE"
        titleLabel.textColor = K.Color.greenSkinProblemQuint
        
        resultLabel.text = "Dry skin"
        
        descriptionLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 48, height: 0)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.text = "Feeling of tightness and roughness. It may also acquire an ashy gray color, with occurrence of desquamation, itching, redness and small cracks."
        textHeight = descriptionLabel.requiredHeight
        descriptionLabel.sizeToFit()
        
    }
    
    func configureLayout() {
        
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
            make.height.equalTo(descriptionLabel.requiredHeight)
            make.top.equalTo(resultLabel.snp.bottom).offset(10)
        }
        
    }
    
}

struct ResultTypeViewPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            ResultTypeView()
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
        .previewDisplayName("iPhone 14")
        .ignoresSafeArea()
        
        ViewPreview {
            ResultTypeView()
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        .previewDisplayName("iPhone 8")
        .ignoresSafeArea()
    }
}
