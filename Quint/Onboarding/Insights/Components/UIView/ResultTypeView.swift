//
//  ResultTypeView.swift
//  Quint
//
//  Created by Vendly on 17/10/22.
//

import UIKit
import SnapKit

class ResultTypeView: UIView {

    private let titleLabel = TitleLabel()
    private let resultLabel = ResultLabel()
    private let descriptionLabel = DescriptionLabel()
    private let backgroundImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = K.Color.greenButtonQuint
        layer.cornerRadius = 10
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
        
        backgroundImage.image = UIImage(named: "face_2_logo")
        backgroundImage.layer.compositingFilter = "overlayBlendMode"
        backgroundImage.sizeToFit()
        
//        applyGradient(colours: [K.Color.greenLightQuint, K.Color.greenQuint], locations: [0,1])
        titleLabel.text = "SKIN TYPE"
        resultLabel.text = "Dry skin"
        
        descriptionLabel.numberOfLines = 4
        descriptionLabel.text = "Feeling of tightness and roughness. It may also acquire an ashy gray color, with occurrence of desquamation, itching, redness and small cracks."
        
    }
    
    func configureLayout() {
        
        addSubview(backgroundImage)
        addSubview(titleLabel)
        addSubview(resultLabel)
        addSubview(descriptionLabel)
        
        backgroundImage.snp.makeConstraints { make in
            make.leading.equalTo(148)
            make.top.equalTo(-56)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(28)
            make.width.equalToSuperview().offset(-48)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.width.equalToSuperview().offset(-48)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(10)
            make.width.equalToSuperview().offset(-48)
        }
        
    }
    
}
