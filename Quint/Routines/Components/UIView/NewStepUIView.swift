//
//  NewStepUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 17/10/22.
//

import UIKit

class NewStepUIView: UIView {

    let height = 52
    var categoryId : NSNumber?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.cornerRadius = 8.0
        self.isUserInteractionEnabled = true
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var containerView = UIView()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .interRegular(size: 16)
        return label
    }()
    
    var imagePlus: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "PlusIcon")
        image.tintColor = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
        return image
    }()
    
    func setCategory(category: CategoryModel){
        titleLabel.text = category.title
        titleLabel.sizeToFit()
        categoryId = category.id
    }
    
    override func configureLayout() {
        
        containerView.multipleSubviews(view: titleLabel, imagePlus)
        addSubview(containerView)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        imagePlus.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(titleLabel)
        }
        
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-40)
            make.height.centerX.equalToSuperview()
        }
    }
    
    
}
