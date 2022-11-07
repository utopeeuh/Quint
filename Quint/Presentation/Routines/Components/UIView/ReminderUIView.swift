//
//  ReminderUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 11/10/22.
//

import Foundation
import SnapKit

class ReminderUIView: UIView {
    
    var height : CGFloat = 0
    
    private let reminderIconView: UIImageView = {
        let imageView = UIImageView()
        let targetSize = CGSize(width: 20, height: 20)
        imageView.image = UIImage(named: "ReminderIcon")
        return imageView
    }()
    
    private var reminderRoutine: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 108, height: 0)
        label.text = "Unlock today skin condition log by finishing at least one routine"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.textColor = UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1)
        label.font = .interMedium(size: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        self.layer.cornerRadius = 8
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    override func configureLayout() {
        
        multipleSubviews(view: reminderIconView, reminderRoutine)
        
        reminderIconView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        reminderRoutine.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(reminderRoutine.requiredHeight)
            make.left.equalTo(reminderIconView.snp.right).offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        height = reminderRoutine.requiredHeight+24
    }
    
    func hide(){
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { completion in
            self.isHidden = true
        }
    }
    
}
