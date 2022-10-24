//
//  ProductDetailTopSectionView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 13/10/22.
//

import Foundation
import SnapKit
import UIKit
import Kingfisher

class ProductDetailTopView: UIView{
    
    private var imageFrame = UIView()
    private var imageView = UIImageView()
    
    private var textStack = UIStackView()
    private var typeLabel: ProductCategoryLabel!
    private var nameLabel = UILabel()
    private var brandLabel = UILabel()
    
    private var ratingView = RatingView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func configureComponents(){
        
        imageFrame.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 328)
        imageFrame.backgroundColor = K.Color.whiteQuint
        imageFrame.addSubview(imageView)
        
        //set image
        let newPhoto = Photo("1", 150, "", "https://www.soco.id/cdn-cgi/image/w=150,format=auto,dpr=1.45/https://images.soco.id/29fbc95c-e81a-4afb-8c68-57530c3d7a94-.jpg")
        assignPhoto(newPhoto)
        
        //adjust labels
        typeLabel = ProductCategoryLabel("toner")
        
        nameLabel.numberOfLines = 0
        nameLabel.text = "Forest Fresh Skin"
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.font = .clashGroteskMedium(size: 24)
        nameLabel.sizeToFit()
        
        brandLabel.text = "by Innisfree"
        brandLabel.numberOfLines = 0
        brandLabel.lineBreakMode = .byWordWrapping
        brandLabel.font = .interRegular(size: 16)
        brandLabel.sizeToFit()
        
        //create left stack
        textStack.axis = .vertical
        textStack.spacing = 12
        textStack.alignment = .leading
        
        textStack.addArrangedSubview(typeLabel)
        textStack.addArrangedSubview(nameLabel)
        textStack.addArrangedSubview(brandLabel)
        
        // rating
        
    }
    
    func getTextStackHeight() -> CGFloat{
        return typeLabel.height+nameLabel.requiredHeight+brandLabel.requiredHeight+12*2
    }
    
    func getTotalHeight() -> CGFloat{
        return getTextStackHeight()+328+24
    }
    
    func assignPhoto(_ photo: Photo){
        imageView.kf.setImage(with: URL(string: photo.download_url)!) { res in
            if case .success(let value)  = res   {
                ImageCache.default.store(value.image, forKey: photo.download_url)
            }
        }
    }
    
    override func configureLayout(){
        //frame, image, main stack
        
        addSubview(imageFrame)
        addSubview(textStack)
        addSubview(ratingView)
        
        imageFrame.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(328)
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(0.71*UIScreen.main.bounds.width)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.width.equalTo(typeLabel.width)
            make.height.equalTo(typeLabel.height)
        }
        
        textStack.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(imageFrame.snp.bottom).offset(24)
            make.width.equalTo((UIScreen.main.bounds.width-40))
            make.height.equalTo(getTextStackHeight())
        }
        
        ratingView.snp.makeConstraints { make in
            make.width.equalTo(ratingView.snp.width)
            make.height.equalTo(ratingView.snp.height)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(textStack.snp.bottom)
        }
    }
}
