//
//  ReminderUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 11/10/22.
//

import Foundation
import SnapKit

class ReminderUIView: UIView {
    
    lazy var hStackReminder: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.layer.backgroundColor = CGColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        stackView.layer.cornerRadius = 8.0
        stackView.isHidden = false
        return stackView
    }()
    
    private let reminderIconView: UIImageView = {
        let imageView = UIImageView()
        let targetSize = CGSize(width: 20, height: 20)
        var image = UIImage(systemName: "exclamationmark.circle.fill")?.withTintColor(UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1))
        let scaledImage = image?.scalePreservingAspectRatio(
            targetSize: targetSize
        )
        imageView.image = scaledImage
        return imageView
    }()
    
    private var reminderRoutine: UILabel = {
        let label = UILabel()
        label.text = "Unlock today skin condition log by finishing at least one routine"
        label.numberOfLines = 0
        label.textColor = UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1)
        label.font = .interMedium(size: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8.0
        self.isUserInteractionEnabled = true
        configureComponents()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureComponents()
        configureLayout()
        
    }
    
    func configureComponents() {
        hStackReminder.addArrangedSubview(reminderIconView)
        hStackReminder.addArrangedSubview(reminderRoutine)
    }
    
    func configureLayout() {
        self.addSubview(hStackReminder)
        hStackReminder.snp.makeConstraints { make in
            make.height.equalTo(66)
            make.width.equalTo(self.safeAreaInsets).offset(350)
        }
        
        reminderIconView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaInsets).offset(23.5)
            make.left.equalTo(self.safeAreaInsets).offset(16)
        }
        
        reminderRoutine.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaInsets).offset(17.5)
            make.left.equalTo(reminderIconView.snp.right).offset(12)
            make.right.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
