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
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        //        label.font = UIFont(name: "ClashGrostek-Medium", size: 30.0)
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "The extra miles for your skin health."
        label.textAlignment = .justified
        return label
        
    }()
    
    private let captionLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1)
        //        label.font = UIFont(name: "Inter-Regular", size: 16.0)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Find the best skin care product and ingredients for yourself with personalized information while tracking your facial skin routine progress."
        label.textAlignment = .justified
        return label
        
    }()
    
    private let startBtn: UIButton = {
        
        let gradient = CAGradientLayer()
//        gradient.greenGradient()
//        gradient.colors = [CGColor(red: 255/255, green: 77/255, blue: 109/255, alpha: 1), CGColor(red: 208/255, green: 46/255, blue: 75/255, alpha: 1)]
        
        let button = UIButton(type: .system)
        button.setTitle("Get started", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        
        gradient.frame = button.bounds
        button.layer.insertSublayer(gradient, at: 0)
        button.layer.masksToBounds = true
        
        button.setTitleColor(UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1), for: .normal)
        button.isEnabled = true
        return button
        
    }()
    
//    lazy var signInBtn: ASAuthorizationAppleIDButton = {
//
//        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
//
//        button.layer.cornerRadius = 8
//        button.backgroundColor = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
//        button.layer.borderWidth = 2.0
//        button.layer.borderColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1).cgColor
//        button.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
//
//        return button
//
//    }()

    private let signInButton: UIButton = {

        let button = UIButton()
        
        button.setTitle("Continue with Apple", for: .normal)
        button.setTitleColor(UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1), for: .normal)
        
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.setImage(UIImage(named: "apple_logo"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 10)
        
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
            make.centerX.equalTo(view.snp.centerX)
            make.margins.equalTo(70)
            make.width.height.equalTo(140.66)
        }
        
        view.addSubview(taglineLabel)
        taglineLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(350)
        }
        
        view.addSubview(captionLabel)
        captionLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(350)
        }
        
        view.addSubview(startBtn)
        startBtn.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.height.equalTo(50)
            make.width.equalTo(350)
        }

        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(350)
        }
        
        let stack = UIStackView(arrangedSubviews: [taglineLabel,
                                                   captionLabel,
                                                   startBtn,
                                                   signInButton])
        stack.axis = .vertical
        stack.spacing = 12

        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
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
        let controller = QuizViewController()
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
