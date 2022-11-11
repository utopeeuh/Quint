//
//  LogModal.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 10/10/22.
//

import UIKit
import SnapKit

@available(iOS 16.0, *)
class LogModal: UIView {
    
    var delegate: LogModalDelegate?
    
    private var containerHeight : CGFloat = 0
    
    private let background: UIView = {
        let v = UIView()
        v.backgroundColor = .black.withAlphaComponent(0.6)
        return v
    }()
    
    private let container: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 12.0
        v.isUserInteractionEnabled = true
        return v
    }()
    
    private var closeBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "LogModalCloseIcon"), for: .normal)
        
        return b
    }()
    
    private var pencilIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PencilIcon")
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Daily skin condition log unlocked"
        label.font = .clashGroteskMedium(size: 24)
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        return label
    }()
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "You can now fill your daily skin condition log"
        label.font = .interRegular(size: 16)
        label.textColor = UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1)
        return label
    }()
    
    private var fillLogButton: UIButton = {
        let button = UIButton()
        button.setTitle("Fill in log", for: .normal)
        button.backgroundColor = K.Color.greenQuint
        button.titleLabel?.font = .clashGroteskMedium(size: 16)
        button.layer.cornerRadius = 8.0
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.frame = UIScreen.main.bounds
        self.isUserInteractionEnabled = true
        self.alpha = 0
        self.isHidden = true
        
        configureUI()
        hide()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureComponents() {
        container.multipleSubviews(view: pencilIcon, titleLabel, subTitleLabel, fillLogButton, closeBtn)
        
        container.subviews.forEach { view in
            if let label = view as? UILabel{
                label.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-140, height: 0)
                label.lineBreakMode = .byWordWrapping
                label.numberOfLines = 0
                label.sizeToFit()
                label.textAlignment = .center
            }
        }
        
        let closeGesture = UITapGestureRecognizer(target: self, action: #selector(hide))
        background.addGestureRecognizer(closeGesture)
        closeBtn.addTarget(self, action: #selector(hide), for: .touchUpInside)
        
        fillLogButton.addTarget(self, action: #selector(goToLog), for: .touchUpInside)
        
        containerHeight = 274 + titleLabel.requiredHeight + subTitleLabel.requiredHeight
    }
    
    override func configureLayout() {
        self.addSubview(background)
        self.addSubview(container)
        
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        container.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width-106)
            make.height.equalTo(containerHeight)
        }
        
        closeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(30)
        }
        
        pencilIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(45)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-64)
            make.centerX.equalToSuperview()
            make.top.equalTo(pencilIcon.snp.bottom).offset(37)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-64)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        fillLogButton.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-64)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(24)
        }
    }
    
    func show(){
        self.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
        }
    }
    
    @objc func hide(){
        print("yo")
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }){ completion in
            self.isHidden = true
        }
    }
    
    @objc func goToLog(){
        delegate?.goToLog()
    }
}
