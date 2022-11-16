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
    
    var product: ProductModel? {
        didSet {
            setData()
        }
    }
    
    var imgPlaceholder : UIView = {
        let view = UIView()
        view.backgroundColor = K.Color.bgQuint
        view.layer.cornerRadius = 10
        return view
    }()
    
    var img : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = K.Color.bgQuint
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.setContentHuggingPriority(.defaultLow, for: .vertical)
        return img
    }()
    
    var nameLabel : UILabel = {
        
        let labelWidth = (UIScreen.main.bounds.width - 124)/2
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .interMedium(size: 16)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: labelWidth, height: 0)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
        
    var brandLabel : UILabel = {
        let labelWidth = (UIScreen.main.bounds.width - 124)/2
        
        let label = UILabel()
        label.textColor = K.Color.greyDarkQuint
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .interRegular(size: 13)
        label.frame = CGRect(x: 0, y: 0, width: labelWidth, height: 0)
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
        label.font = .interSemiBold(size: 14)
        
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        // add icon
        label.icon = UIImage(named: "MatchingIngredientIcon")  // Set icon image
        label.iconPadding = 6              // Set padding between icon and label
        label.topOffset = 2.5
        
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
        configureUI()
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
        imgPlaceholder.removeFromSuperview()
        img.removeFromSuperview()
        nameLabel.removeFromSuperview()
        brandLabel.removeFromSuperview()
        ratingLabel.removeFromSuperview()
    }
    
    deinit {
        info = nil
    }
    
    override func configureComponents(){
        layer.cornerRadius = 10
        backgroundColor = K.Color.whiteQuint

        contentView.multipleSubviews(view: img,
                                     imgPlaceholder, nameLabel, brandLabel, ratingLabel)
    }
    
    override func configureLayout(){
        
        imgPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.height.width.equalTo(150)
            make.centerX.equalTo(contentView)
        }
        
        img.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.height.width.equalTo(150)
            make.centerX.equalTo(contentView)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imgPlaceholder.snp.bottom).offset(12)
            make.centerX.equalTo(contentView)
            make.width.equalTo(contentView).offset(-40)
        }
      
        brandLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.width.equalTo(contentView).offset(-40)
            make.centerX.equalTo(contentView)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(brandLabel.snp.bottom).offset(12)
            make.width.equalTo(contentView).offset(-40)
            make.centerX.equalTo(contentView)
        }
    }
    
    func setData(){
        nameLabel.text = product?.name
        brandLabel.text = product?.brand.uppercased()
        ratingLabel.text = "\(String(describing: product!.matchingIngredients)) Matching ingredients"
        
        nameLabel.sizeToFit()
        brandLabel.sizeToFit()
    }
    
    func assignPhoto(){
        guard let data = info else {
            return
        }
        
        img.kf.setImage(with: URL(string: data.download_url)!) { res in
            if case .success(let value)  = res   {
                ImageCache.default.store(value.image, forKey: data.download_url)
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.imgPlaceholder.alpha = 0
                }) { completion in
                    self.imgPlaceholder.isHidden = true
                }
                
            }
        }
    }
    
}

