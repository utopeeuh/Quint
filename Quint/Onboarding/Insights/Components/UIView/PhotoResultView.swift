//
//  PhotoResultView.swift
//  Quint
//
//  Created by Vendly on 19/10/22.
//

import UIKit
import SnapKit

class PhotoResultView: UIView {
    
    private let titleLabel = UILabel()
    private let photoLogImage = UIImageView()
    private let retakeButton = UIButton()
    
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
            
            self.backgroundColor = K.Color.whiteQuint
            self.layer.cornerRadius = 10
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowColor = K.Color.shadowQuint.cgColor
            self.layer.shadowOpacity = 5.0
            
            titleLabel.text = "Skin Log Photo"
            titleLabel.font = .clashGroteskMedium(size: 20)
            titleLabel.textColor = K.Color.blackQuint
            
            photoLogImage.image = UIImage(named: "receipt_logo")
            photoLogImage.layer.cornerRadius = 8
            photoLogImage.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
            
            retakeButton.setTitle("Retake", for: .normal)
            retakeButton.titleLabel?.font = .interMedium(size: 13)
            retakeButton.setTitleColor(K.Color.greyDarkQuint, for: .normal)
            retakeButton.layer.cornerRadius = 14
            retakeButton.backgroundColor = K.Color.greyWhiteQuint
            
        }
        
        func configureLayout() {

            multipleSubviews(view: titleLabel,
                                   photoLogImage,
                                   retakeButton)
            
            titleLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(24)
            }
            
            photoLogImage.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().offset(-40)
                make.top.equalTo(titleLabel.snp.bottom).offset(24)
                make.height.equalTo(302)
            }
            
            retakeButton.snp.makeConstraints { make in
                make.width.equalTo(63)
                make.height.equalTo(28)
                make.top.equalTo(photoLogImage.snp.top).offset(10)
                make.trailing.equalTo(photoLogImage).offset(-10)
            }
            
        }

    
}
