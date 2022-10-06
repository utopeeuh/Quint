//
//  ViewController.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 03/10/22.
//

import AuthenticationServices
import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    private let logoImage: UIImageView = {
        
        let logo = UIImageView()
        logo.dropShadow()
        logo.image = UIImage(named: "quint_logo")
        logo.tintColor = .white
        return logo
        
    }()
    
    private let taglineLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.text = "The extra miles for your skin health."
        label.font = .clashGroteskMedium(size: 30)
        label.textAlignment = .center
        return label
        
    }()
    
    private let captionLabel: UILabel = {
        
        let label = UILabel()
        
        label.numberOfLines = 3
        label.textColor = UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1)
        label.text = "Find the best skin care product and ingredients for yourself with personalized information while tracking your facial skin routine progress."
        label.font = .interRegular(size: 16)
        label.textAlignment = .center
        
        return label
        
    }()
    
    private let startBtn: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Get started", for: .normal)
        button.titleLabel?.font = .clashGroteskMedium(size: 18)
        
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        button.setTitleColor(UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1), for: .normal)
        
        // gradient masih ga jalan (bug)
//        let gradient = CAGradientLayer()
//        gradient.colors = [CGColor(red: 255/255, green: 87/255, blue: 51/255, alpha: 1), CGColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)]
//        gradient.frame = button.bounds
//        button.layer.insertSublayer(gradient, at: 0)
//        button.layer.masksToBounds = true
        
        return button
        
    }()
    
    private let signInButton: UIButton = {

        let button = UIButton()
        
        button.setTitle("Continue with Apple", for: .normal)
        button.titleLabel?.font = .clashGroteskMedium(size: 18)
        button.setTitleColor(UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1), for: .normal)
        
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.setImage(UIImage(named: "apple_logo"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 25)
        
        button.layer.borderWidth = 1.5
        button.backgroundColor = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
        button.layer.borderColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1).cgColor
        
        button.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        
        return button

    }()
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startBtn.addTarget(self, action: #selector(didTapGetStart), for: .touchUpInside)
        
        configureUI()
    }
    
    func configureUI() {

        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(140)
            make.top.equalToSuperview().offset(171)
        }
        
        view.addSubview(taglineLabel)
        taglineLabel.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.width.equalTo(350)
            make.top.equalTo(logoImage.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(captionLabel)
        captionLabel.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(357)
            make.top.equalTo(taglineLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(startBtn)
        startBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(captionLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().offset(-40)
        }

        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(startBtn.snp.bottom).offset(12)
            make.width.equalToSuperview().offset(-40)
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
        let controller = QuizSkinTypeVC()
        navigationController?.pushViewController(controller, animated: true)
    }

}

extension LoginViewController: ASAuthorizationControllerDelegate {
    
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
            
            print(email)
            print(fullName)
            print(userIdentifier)
            
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

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}
