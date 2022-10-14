//
//  ProductListCell.swift
//  DynamicCell
//
//  Created by Mohannad on 29.03.2021.
//


import UIKit
import Kingfisher
import SMIconLabel

class ProductListCell: UICollectionViewCell {
    
    var img : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .gray
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.setContentHuggingPriority(.defaultLow, for: .vertical)
        return img
    }()
    
    var nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .interMedium(size: 16)
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
        
    var brandLabel : UILabel = {
        let label = UILabel()
        label.textColor = K.Color.greyDarkQuint
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .interRegular(size: 13)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    var ratingLabel: SMIconLabel = {
        let label = SMIconLabel()
        label.textColor = K.Color.greenQuint
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "99%"
        label.font = .interSemi(size: 14)
        
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        // add icon
        label.icon = UIImage(named: "ThumbsUpFilledIcon")  // Set icon image
        label.iconPadding = 4                  // Set padding between icon and label
        label.iconPosition = (.left, .top)   // Icon position
        
        return label
    }()

    var info : Photo? {
        didSet {
            assignPhoto()
        }
    }
    
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
        info = nil
        img.removeFromSuperview()
        nameLabel.removeFromSuperview()
        brandLabel.removeFromSuperview()
        ratingLabel.removeFromSuperview()
    }
    
    deinit {
        info = nil
    }
    
    func configureComponents(){
        layer.cornerRadius = 10
        backgroundColor = K.Color.whiteQuint

        contentView.addSubview(img)
        contentView.addSubview(nameLabel)
        contentView.addSubview(brandLabel)
        contentView.addSubview(ratingLabel)
    }
    
    func configureLayout(){
        img.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.height.width.equalTo(150)
            make.centerX.equalTo(contentView)
//            make.width.equalTo(contentView)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(img.snp.bottom).offset(12)
            make.centerX.equalTo(contentView)
            make.width.equalTo(contentView).offset(-24)
        }
      
        brandLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
//            make.bottom.equalTo(contentView.snp.bottom).offset(-12)
            make.width.equalTo(contentView).offset(-24)
            make.centerX.equalTo(contentView)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(brandLabel.snp.bottom).offset(12)
            make.width.equalTo(contentView)
            make.centerX.equalTo(contentView)
        }
    }
    
    func assignPhoto(){
        guard let data = info else {
            return
        }
        
        img.kf.setImage(with: URL(string: data.download_url)!) { res in
            if case .success(let value)  = res   {
                ImageCache.default.store(value.image, forKey: data.download_url)
            }
        }
    }
    
}

