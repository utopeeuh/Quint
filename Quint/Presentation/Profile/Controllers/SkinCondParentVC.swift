//
//  SkinCondParentVC.swift
//  Quint
//
//  Created by Vendly on 16/11/22.
//

import UIKit
import SnapKit

@available(iOS 16.0, *)
class SkinCondParentVC: UIViewController {
    
    var user: UserModel?
    public let backBtn = BackButton()
    private let skinCondLabel = UILabel()
    public var skinCondView = SkinConditionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func configureComponents() {
        
        view.backgroundColor = K.Color.bgQuint
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        backBtn.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        
        skinCondLabel.textColor = K.Color.blackQuint
        skinCondLabel.text = "Sensitive Skin"
        skinCondLabel.font = .interMedium(size: 16)
        
        skinCondView.backgroundColor = K.Color.bgQuint
        skinCondView.skinConditionLabel.text = "Sensitive skin condition"
        
        skinCondView.nextButton.setText("Save")
        skinCondView.nextButton.removeTarget(nil, action: nil, for: .allEvents)
        skinCondView.nextButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        
    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: backBtn,
                                    skinCondLabel,
                                    skinCondView,
                                    skinCondView.nextButton)

        backBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(60)
        }
        
        skinCondLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
        
        skinCondView.snp.makeConstraints { make in
            make.top.equalTo(skinCondLabel.snp.bottom).offset(48)
            make.width.height.equalToSuperview()
        }
        
        skinCondView.nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalToSuperview().offset(-40)
        }
        
    }
    
    @objc func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapSave() {
        UserRepository.shared.updateUserSkinCondition(isSensitive: skinCondView.isSensitive())
        navigationController?.popViewController(animated: true)
    }
}
