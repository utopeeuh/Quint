//
//  ViewController.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 03/10/22.
//

import AuthenticationServices
import UIKit
import SnapKit
import SwiftUI

@available(iOS 16.0, *)
class LoginVC: UIViewController {

    private let topSpacer = UIView()
    private let bottomSpacer = UIView()
    private let logoImage = UIImageView()
    private let taglineLabel = UILabel()
    private let captionLabel = UILabel()
    private let startButton = OnboardingButton()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.Color.bgQuint
        configureUI()
    }
    
    override func configureComponents() {
    
        logoImage.dropShadow()
        logoImage.image = UIImage(named: "quint_logo")
        logoImage.tintColor = .white

        taglineLabel.numberOfLines = 2
        taglineLabel.textColor = K.Color.blackQuint
        taglineLabel.text = "The extra miles for your skin health."
        taglineLabel.font = .clashGroteskMedium(size: 30)
        taglineLabel.textAlignment = .center

        captionLabel.numberOfLines = 3
        captionLabel.textColor = K.Color.greyDarkQuint
        captionLabel.text = "Find the best skin care product and ingredients for yourself with personalized information while tracking your facial skin routine progress."
        captionLabel.font = .interRegular(size: 16)
        captionLabel.textAlignment = .center
        captionLabel.numberOfLines = 0
        captionLabel.lineBreakMode = .byWordWrapping
        captionLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 0)
        captionLabel.sizeToFit()

        startButton.setText("Get started")
        startButton.addTarget(self, action: #selector(didTapGetStart), for: .touchUpInside)
    
    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: logoImage,
                                    taglineLabel,
                                    captionLabel,
                                    startButton)
        
        logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset((UIScreen.main.bounds.height-47)/5000*671)
        }

        taglineLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(72)
            make.top.equalTo(logoImage.snp.bottom).offset(60)
        }

        captionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalToSuperview().offset(-40)
            make.top.equalTo(taglineLabel.snp.bottom).offset(18)
        }

        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(captionLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().offset(-40)
        }

    }
    
    // MARK: - Selectors
    
    @objc func didTapGetStart() {
        let controller = OnboardingQuizVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
