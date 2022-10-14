//
//  QuizSkinTypeVC.swift
//  Quint
//
//  Created by Vendly on 05/10/22.
//

import UIKit
import SnapKit
import SwiftUI

class QuizSkinTypeVC: ProgressViewController {

    private let backButton = UIButton()
    
    private let skinTypeLbl: UILabel = {

        let label = UILabel()
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.text = "What is your skin type?"
        label.font = .clashGroteskMedium(size: 30)
        label.textAlignment = .left
        return label

    }()

    private let skinTypeBox = CustomBoxView()
    
    private let nextButton: UIButton = {

        let button = UIButton()

        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = .clashGroteskMedium(size: 18)

        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        button.setTitleColor(UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1), for: .normal)

        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowColor = UIColor(red: 16/255, green: 24/255, blue: 40/255, alpha: 0.05).cgColor
        button.layer.shadowOpacity = 5.0

//        button.isEnabled = false

        return button

    }()
     
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = K.Color.bgQuint
        
        backButton.setImage(UIImage(named: "arrow_back"), for: .normal)
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        
        skinTypeBox.labelContainer.text = "Normal skin"
//        skinTypeBox.labelContent.text = "This skin is neither too dry nor too oily. It has regular texture, no imperfections and a clean, soft appearance, and does not need special care."
        
        configureUI()
    }
    
    override func configureLayout() {
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        view.addSubview(skinTypeLbl)
        skinTypeLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(super.navBarView).offset(20)
            make.width.equalToSuperview().offset(-40)
        }

        view.addSubview(skinTypeBox)
        skinTypeBox.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(skinTypeLbl.snp.bottom).offset(32)
            make.width.equalToSuperview().offset(-5)
            make.height.equalTo(150)
        }

        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-62)
            make.width.equalToSuperview().offset(-40)
        }

    }
    
    // MARK: - Selectors
    
    @objc func didTapNext() {
        let controller = QuizSkinCondVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

struct QuizSkinTypeVCPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            QuizSkinTypeVC()
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
        .previewDisplayName("iPhone 14")
//        .ignoresSafeArea()
        
        ViewControllerPreview {
            QuizSkinTypeVC()
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        .previewDisplayName("iPhone 8")
        .ignoresSafeArea()
    }
}
