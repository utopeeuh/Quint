//
//  ProfileParentVC.swift
//  Quint
//
//  Created by Vendly on 16/11/22.
//

import UIKit
import SnapKit

@available(iOS 16.0, *)
class SkinTypeParentVC: UIViewController {
    
    var user: UserModel?
    public let backBtn = BackButton()
    private let skinTypeLabel = UILabel()
    public var skinTypeView = SkinTypeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func configureComponents() {
        
        view.backgroundColor = K.Color.bgQuint
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        backBtn.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        
        skinTypeLabel.textColor = K.Color.blackQuint
        skinTypeLabel.text = "Skin Type"
        skinTypeLabel.font = .interMedium(size: 16)
        
        skinTypeView.backgroundColor = K.Color.bgQuint
        skinTypeView.skinTypeLabel.text = "Your skin type"
        
        skinTypeView.nextButton.setText("Save")
        skinTypeView.nextButton.removeTarget(nil, action: nil, for: .allEvents)
        skinTypeView.nextButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)

//        skinTypeView.selectSkinType(index: Int(truncating: user?.skinTypeId ?? 1))
    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: backBtn,
                                    skinTypeLabel,
                                    skinTypeView,
                                    skinTypeView.nextButton)
        
        backBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(9)
        }
        
        skinTypeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backBtn)
        }
        
        skinTypeView.snp.makeConstraints { make in
            make.top.equalTo(skinTypeLabel.snp.bottom).offset(48)
            make.width.height.equalToSuperview()
        }
        
        skinTypeView.nextButton.snp.makeConstraints { make in
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
        UserRepository.shared.updateUserSkinType(skinTypeId: skinTypeView.getSkinType())
        navigationController?.popViewController(animated: true)
    }
    
}
