//
//  CustomBoxView.swift
//  Quint
//
//  Created by Vendly on 13/10/22.
//

import UIKit
import SnapKit
import SwiftUI

class CustomBoxView: UIView {
    
    private let containerBox = UIView()
    private let contentBox = UIView()
    public var labelContainer = UILabel()
    public var labelContent = UILabel()
    
    private var leftBorder: CALayer?
    private let borderWidth: CGFloat = 1.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        if leftBorder == nil {
            addLeftBorder()
        }

        // Update the frames based on the current bounds
        leftBorder?.frame = CGRect(x: 0,
                               y: 0,
                               width: borderWidth,
                               height: contentBox.frame.height)

        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        configureComponents()
        configureLayout()
    }
    
    func configureComponents() {
        
        containerBox.backgroundColor = K.Color.whiteQuint
        containerBox.layer.cornerRadius = 8
        containerBox.layer.borderWidth = 1.5
        containerBox.layer.borderColor = K.Color.greenButtonQuint.cgColor
        
//        labelContainer.text = "Normal Skin"
        labelContainer.textColor = K.Color.greenButtonQuint
        labelContainer.font = .interSemiBold(size: 16)
        
        contentBox.frame = CGRect(x: 0, y: 0, width: 0, height: labelContent.requiredHeight)
        contentBox.backgroundColor = K.Color.bgQuint
        
        labelContent.text = "This skin is neither too dry nor too oily. It has regular texture, no imperfections and a clean, soft appearance, and does not need special care."
        labelContent.numberOfLines = 0
        labelContent.textColor = K.Color.blackQuint
        labelContent.font = .interRegular(size: 14)
        labelContent.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-51.5, height: 0)
        labelContent.lineBreakMode = .byWordWrapping
        labelContent.sizeToFit()
        
    }
    
    func configureLayout() {
        
        addSubview(containerBox)
        addSubview(labelContainer)
        addSubview(contentBox)
        addSubview(labelContent)
        
        containerBox.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(52)
            make.width.equalToSuperview().offset(-40)
        }
        
        labelContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(containerBox)
            make.height.equalTo(containerBox)
            make.width.equalToSuperview().offset(-72)
        }
        
        contentBox.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(containerBox.snp.bottom).offset(14)
            make.height.equalTo(63)
            make.width.equalTo(containerBox)
        }
        
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

struct CustomBoxViewPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            CustomBoxView()
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
        .previewDisplayName("iPhone 14")
        
        ViewPreview {
            CustomBoxView()
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        .previewDisplayName("iPhone 8")
    }
}
