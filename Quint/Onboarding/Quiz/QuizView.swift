//
//  SkinTypeStackView.swift
//  Quint
//
//  Created by Vendly on 12/10/22.
//

import UIKit
import SnapKit

class QuizView: UIViewController {
    
    var leftBorder: CALayer?
    let borderWidth: CGFloat = 1.5
    
    private let containerBox: UIView = {

        let view = UIView()
        view.backgroundColor = K.Color.whiteQuint
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1.5
        view.layer.borderColor = K.Color.greenButtonQuint.cgColor

        return view

    }()

    private let labelContainer: UILabel = {

        let label = UILabel()
        label.text = "Normal Skin"
        label.textColor = K.Color.greenButtonQuint
        label.font = .interSemiBold(size: 16)
        return label

    }()

    private let contentBox: UIView = {

        let view = UIView()
        view.backgroundColor = K.Color.bgQuint
        return view

    }()

    private let labelContent: UILabel = {

        let label = UILabel()
        label.text = "This skin is neither too dry nor too oily. It has regular texture, no imperfections and a clean, soft appearance, and does not need special care."
        label.numberOfLines = 0
        label.textColor = K.Color.blackQuint
        label.font = .interRegular(size: 14)
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-51.5, height: 0)
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label

    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        view.backgroundColor = K.Color.bgQuint
        
        if leftBorder == nil {
            addLeftBorder()
        }

        // Update the frames based on the current bounds
        leftBorder?.frame = CGRect(x: 0,
                                   y: 0,
                                   width: borderWidth,
                                   height: contentBox.frame.height)
        
    }
    
    override func configureComponents() {
        
        contentBox.frame = CGRect(x: 0, y: 0, width: 0, height: labelContent.requiredHeight)
        
    }
    
    override func configureLayout() {
        
        view.addSubview(containerBox)
        containerBox.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(300)
            make.height.equalTo(52)
            make.width.equalToSuperview().offset(-40)
        }
        
        view.addSubview(labelContainer)
        labelContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(containerBox)
            make.height.equalTo(containerBox)
            make.width.equalToSuperview().offset(-72)
        }
        
        view.addSubview(contentBox)
        contentBox.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(containerBox.snp.bottom).offset(14)
            make.height.equalTo(63)
            make.width.equalTo(containerBox)
        }
        
        view.addSubview(labelContent)
        labelContent.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(31.5)
            make.top.equalTo(contentBox)
            make.height.equalTo(labelContent.requiredHeight)
            make.width.equalToSuperview().offset(-51.5)
        }
        
    }
    
    private func addLeftBorder() {

        leftBorder = CALayer()

        leftBorder?.backgroundColor = K.Color.greenButtonQuint.cgColor

        self.contentBox.layer.addSublayer(leftBorder!)
    }
    
}
