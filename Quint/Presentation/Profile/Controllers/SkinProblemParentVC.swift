//
//  SkinProblemParentVC.swift
//  Quint
//
//  Created by Vendly on 16/11/22.
//

import UIKit
import SnapKit

@available(iOS 16.0, *)
class SkinProblemParentVC: UIViewController {
    
    var problemList: [ProblemModel?] = []
    public let backBtn = BackButton()
    private let skinProblemLabel = UILabel()
    public let skinProblemView = SkinProblemView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func configureComponents() {
        
        view.backgroundColor = K.Color.bgQuint
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        backBtn.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        
        skinProblemLabel.textColor = K.Color.blackQuint
        skinProblemLabel.text = "Skin Problem"
        skinProblemLabel.font = .interMedium(size: 16)
        
        skinProblemView.backgroundColor = K.Color.bgQuint
        skinProblemView.skinProblemLabel.text = "Your skin problem"
        skinProblemView.nextButton.setText("Save")
        
        skinProblemView.nextButton.removeTarget(nil, action: nil, for: .allEvents)
        skinProblemView.nextButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: backBtn,
                                    skinProblemLabel,
                                    skinProblemView,
                                    skinProblemView.nextButton)
        
        backBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(9)
        }
        
        skinProblemLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backBtn)
        }
        
        skinProblemView.snp.makeConstraints { make in
            make.top.equalTo(skinProblemLabel.snp.bottom).offset(48)
            make.width.height.equalToSuperview()
        }
        
        skinProblemView.nextButton.snp.makeConstraints { make in
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
//        save data
        ProblemsRepository.shared.updateSkinProblem(ids: skinProblemView.getSelectedProblems())
        navigationController?.popViewController(animated: true)
    }
}

