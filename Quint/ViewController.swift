//
//  ViewController.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 03/10/22.
//

import UIKit

class ViewController: UIViewController {

//    private let startBtn: UIButton = {
//
//        let button = UIButton(type: .system)
//        button.setTitle("Get started", for: .normal)
//        button.layer.cornerRadius = 5
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        button.backgroundColor = UIColor(red: 255/255, green: 135/255, blue: 178/255, alpha: 1.5)
//        button.setTitleColor(.white, for: .normal)
//        button.tintColor = .white
//        return button
//
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .system)
        button.setTitle("Get started", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(red: 255/255, green: 135/255, blue: 178/255, alpha: 1.5)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = true

        view.addSubview(button)
        view.backgroundColor = .systemGray
        
//        configureUI()
    }
    
//    func configureUI() {
//
//        let stack = UIStackView(arrangedSubviews: [startBtn])
//        stack.axis = .vertical
//        stack.spacing = 16
//
//        view.addSubview(stack)
//
//    }



}

