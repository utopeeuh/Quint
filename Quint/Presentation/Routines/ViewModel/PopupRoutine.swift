//
//  PopupRoutine.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 10/10/22.
//

import UIKit
import SnapKit

@available(iOS 16.0, *)
class PopupRoutine: UIView {
    
    private var imagePencil: UIImageView = {
        let imageView = UIImageView()
        let targetSize = CGSize(width: 78, height: 78)
        var image = UIImage(systemName: "pencil")?.withTintColor(K.Color.greenQuint)
        let scaledImage = image?.scalePreservingAspectRatio(
            targetSize: targetSize
        )
        imageView.image = scaledImage
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Daily skin condition log unlocked"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        return label
    }()
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "You can now fill your daily skin condition log"
        label.font = label.font.withSize(16)
        label.textColor = UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1)
        return label
    }()
    
    private var fillLogButton: UIButton = {
        let button = UIButton()
        button.setTitle("Fill in log", for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = K.Color.greenQuint
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    private let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 5.0
        return v
    }()
    
    @objc private func animateOut() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        } completion: { complete in
            if complete {
                self.removeFromSuperview()
            }
        }

    }
    
    @objc private func animateIn() {
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 1
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.container.transform = .identity
            self.alpha = 1
        }

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray.withAlphaComponent(0.6)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        self.frame = UIScreen.main.bounds
        
        self.addSubview(container)
        container.snp.makeConstraints { make in
            make.centerY.equalTo(self.center.y)
            make.centerX.equalTo(self.center.x)
            make.width.equalTo(250)
            make.height.equalTo(270)
        }
        container.self.addSubview(mainStackView)
        animateIn()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ConfigureUI() {
        configureComponents()
        imagePencil.snp.makeConstraints { make in
            make.height.width.equalTo(78)
        }
        mainStackView.snp.makeConstraints { make in
            make.top.left.height.width.equalToSuperview()
        }
    }
    
    override func configureComponents() {
        mainStackView.addArrangedSubview(imagePencil)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(subTitleLabel)
        mainStackView.addArrangedSubview(fillLogButton)
    }
    
}
