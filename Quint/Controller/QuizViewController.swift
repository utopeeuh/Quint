//
//  QuizController.swift
//  Quint
//
//  Created by Vendly on 05/10/22.
//

import UIKit
import SnapKit

class QuizViewController: UIViewController {
    
    private let logoImage: UIImageView = {
        
        let logo = UIImageView()
        logo.dropShadow()
        logo.image = UIImage(named: "quint_logo")
        logo.tintColor = .white
        return logo
        
    }()
    
    private let loggedInLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "The extra miles for your skin health."
        label.textAlignment = .justified
        return label
        
    }()
    
    private let nextBtn: UIButton = {
        
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
        
        view.addSubview(loggedInLabel)
        loggedInLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(350)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.height.equalTo(50)
            make.width.equalTo(350)
        }

        let stack = UIStackView(arrangedSubviews: [loggedInLabel,
                                                   nextBtn])
        stack.axis = .vertical
        stack.spacing = 12

        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        
    }
    
}
