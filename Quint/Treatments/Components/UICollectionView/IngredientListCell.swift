//
//  ProductListCell.swift
//  DynamicCell
//
//  Created by Mohannad on 29.03.2021.
//

import UIKit
import Kingfisher
import SMIconLabel

class IngredientListCell: UICollectionViewCell {
    
    var nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .interMedium(size: 18)
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureComponents()
        configureLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.removeFromSuperview()
    }
    
    func configureComponents(){
        layer.cornerRadius = 10
        backgroundColor = K.Color.whiteQuint
        contentView.addSubview(nameLabel)
    }
    
    func configureLayout(){
        nameLabel.snp.makeConstraints { make in
//            make.top.equalTo(contentView).offset(18)
//            make.bottom.equalTo(contentView).offset(18)
            make.centerX.centerY.equalTo(contentView)
            make.width.equalTo(contentView).offset(-48)
        }
    }
}

