//
//  ViewController.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 03/10/22.
//

import AuthenticationServices
import UIKit
import SnapKit

class LoginController: UIViewController {
    
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
        
        let button = UIButton(type: .system)
        button.setTitle("Get started", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        button.setTitleColor(UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1), for: .normal)
        button.isEnabled = true
        return button
        
    }()
    
    private let signInBtn = ASAuthorizationAppleIDButton()
    
//    private let signInButton: UIButton = {
//
//        let button = UIButton(type: .system)
//        button.setTitle("Continue with Apple", for: .normal)
//        button.layer.cornerRadius = 8
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        button.backgroundColor = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
//        button.layer.borderWidth = 1.5
//        button.layer.borderColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1).cgColor
//        button.setTitleColor(UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1), for: .normal)
//        button.isEnabled = true
//        return button
//
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

        view.addSubview(signInBtn)
        signInBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(350)
        }
        
        let stack = UIStackView(arrangedSubviews: [taglineLabel,
                                                   captionLabel,
                                                   startBtn,
                                                   signInBtn])
        stack.axis = .vertical
        stack.spacing = 12

        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        
    }

}

