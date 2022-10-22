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

class LoginVC: UIViewController {
    
    private let topSpacer = UIView()
    private let bottomSpacer = UIView()
    private let logoImage = UIImageView()
    private let taglineLabel = UILabel()
    private let captionLabel = UILabel()
    private let startButton = OnboardingButton()
    private let signInButton = SignInAppleButton()
    
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

        startButton.setText("Get started")
        startButton.addTarget(self, action: #selector(didTapGetStart), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    
    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: topSpacer,
                                    logoImage,
                                    taglineLabel,
                                    captionLabel,
                                    startButton,
                                    signInButton,
                                    bottomSpacer)
        
        topSpacer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
            make.height.equalTo(bottomSpacer)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(logoImage)
        }
        
        logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-300)
            make.height.equalTo(118)
        }

        taglineLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(72)
            make.top.equalTo(logoImage.snp.bottom).offset(60)
        }

        captionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalToSuperview().offset(-33)
            make.top.equalTo(taglineLabel.snp.bottom).offset(18)
        }

        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(captionLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().offset(-40)
        }

        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(startButton.snp.bottom).offset(12)
            make.width.equalToSuperview().offset(-40)
        }
        
        bottomSpacer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
            make.height.equalTo(topSpacer)
            make.top.equalTo(signInButton)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }

    }
    
    // MARK: - Selectors
    
    @objc func didTapSignIn() {

        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    @objc func didTapGetStart() {
        let controller = OnboardingQuizVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension LoginVC: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok",
                                     style: .cancel,
                                     handler: nil)
        
        alertController.addAction(okAction)
        
        self.present(alertController,
                     animated: true,
                     completion: nil)
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            break
            
        case let passwordCredential as ASPasswordCredential:
        
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            break
            
        default:
            
            print("Failed!")
            
            break
        }
        
    }
    
}

extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}

struct LoginVCPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            LoginVC()
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
        .previewDisplayName("iPhone 14")
        .ignoresSafeArea()
        
        ViewControllerPreview {
            LoginVC()
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        .previewDisplayName("iPhone 8")
        .ignoresSafeArea()
    }
}
