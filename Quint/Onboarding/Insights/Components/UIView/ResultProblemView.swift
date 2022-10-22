//
//  ResultProblemView.swift
//  Quint
//
//  Created by Vendly on 17/10/22.
//

import UIKit
import SnapKit
import SwiftUI

class ResultProblemView: UIView {
    
    private let titleLabel = TitleLabel()
    private let resultLabel = ResultLabel()
    private let descriptionLabel = DescriptionLabel()
    private let backgroundImage = UIImageView()
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
        
        self.layer.cornerRadius = 10
        
//        backgroundImage.image = UIImage(named: "warning_logo")
//        backgroundImage.layer.compositingFilter = "overlayBlendMode"
//        backgroundImage.sizeToFit()
        
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 468)
        self.applyGradient(colours: [K.Color.redLightQuint, K.Color.redQuint], locations: [0,1])
        titleLabel.text = "SKIN PROBLEM"
        titleLabel.textColor = K.Color.redSkinProblemQuint
        
        resultLabel.numberOfLines = 2
        resultLabel.text = "Acne, dark circles, oiliness, redness"
        
        descriptionLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 48, height: 0)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.text = "Acne: uninflamed blackheads to pus-filled pimples or large, red and tender bumps.\n\nDark circles: dark circles under your eyes happen when the skin beneath both eyes appears darkened\n\nOiliness: oversized sebaceous glands produce excessive amounts of sebum giving the appearance of shiny and greasy skin.\n\nRedness: A response of skin tissues to injury or irritation; characterized by pain and swelling and redness and heat."
        textHeight = descriptionLabel.requiredHeight
        descriptionLabel.sizeToFit()
        
    }
    
    func configureLayout() {
        
        multipleSubviews(view: titleLabel,
                               resultLabel,
                               descriptionLabel)
        
//        backgroundImage.snp.makeConstraints { make in
//            make.leading.equalTo(148)
//            make.top.equalTo(-56)
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

struct ResultProblemViewPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            ResultProblemView()
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
        .previewDisplayName("iPhone 14")
        .ignoresSafeArea()
        
        ViewPreview {
            ResultProblemView()
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        .previewDisplayName("iPhone 8")
        .ignoresSafeArea()
    }
}
