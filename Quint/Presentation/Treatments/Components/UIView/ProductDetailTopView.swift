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

@available(iOS 16.0, *)
class ProductDetailTopView: UIView{
    
    private var product: ProductModel!
    
    private var imageFrame = UIView()
    private var imageView = UIImageView()
    
    private var textStack = UIStackView()
    private var typeLabel: ProductCategoryLabel!
    private var nameLabel = UILabel()
    private var brandLabel = UILabel()
    
    private var ratingView: RatingView!
    private var ratingPlaceholder = UIView()
    private var ratedByLabel = UILabel()
    
    init(product: ProductModel) {
        super.init(frame: .zero)
        self.product = product
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
        let newPhoto = Photo(String(describing: product.id), 150, "", product.image)
        assignPhoto(newPhoto)
        
        //adjust labels
        let category = CategoriesRepository.shared.fetchCategory(id: Int(truncating: product.categoryId))
        typeLabel = ProductCategoryLabel(category.title)
        
        nameLabel.numberOfLines = 0
        nameLabel.text = product.name
        nameLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-179, height: 0)
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.font = .clashGroteskMedium(size: 24)
        nameLabel.sizeToFit()
        
        brandLabel.text = "by \(product.brand.uppercased())"
        brandLabel.numberOfLines = 0
        brandLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-179, height: 0)
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
        ratingView = RatingView(productId: Int(truncating: product.id))
        ratingView.delegate = self
        
        ratingPlaceholder.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
        ratingPlaceholder.layer.cornerRadius = 8
        
        ratedByLabel.text = "No internet connection available"
        ratedByLabel.alpha = 0
        ratedByLabel.frame = CGRect(x: 0, y: 0, width: 139, height: 0)
        ratedByLabel.numberOfLines = 0
        ratedByLabel.lineBreakMode = .byWordWrapping
        ratedByLabel.textColor = K.Color.greyQuint
        ratedByLabel.font = .interRegular(size: 12)
        ratedByLabel.textAlignment = .right
        ratedByLabel.sizeToFit()
        
    }
    
    func getTotalHeight() -> CGFloat{
        return typeLabel.height+nameLabel.requiredHeight+brandLabel.requiredHeight+12*2+328+24
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
        addSubview(typeLabel)
        addSubview(nameLabel)
        addSubview(brandLabel)
        addSubview(ratingPlaceholder)
        addSubview(ratingView)
        addSubview(ratedByLabel)
        
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
            make.top.equalTo(imageFrame.snp.bottom).offset(24)
            make.width.equalTo(typeLabel.width)
            make.left.equalToSuperview().offset(40)
            make.height.equalTo(typeLabel.height)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(40)
            make.height.equalTo(nameLabel.requiredHeight)
            make.width.equalTo(UIScreen.main.bounds.width-179)
        }
        
        brandLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(40)
            make.height.equalTo(brandLabel.requiredHeight)
            make.width.equalTo(UIScreen.main.bounds.width-179)
        }
        
        ratingPlaceholder.snp.makeConstraints { make in
            make.width.equalTo(ratingView.width)
            make.height.equalTo(ratingView.height)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(nameLabel.snp.top)
        }
        
        ratingView.snp.makeConstraints { make in
            make.width.equalTo(ratingView.width)
            make.height.equalTo(ratingView.height)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(nameLabel.snp.top)
        }
        
        ratedByLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(ratingView.snp.bottom).offset(10)
            make.width.equalTo(139)
            make.height.equalTo(ratedByLabel.requiredHeight)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            UIView.animate(withDuration: 0.2) {
                self.ratedByLabel.alpha = 1
            }
        }
    }
}

@available(iOS 16.0, *)
extension ProductDetailTopView : RatingViewDelegate {
    func displayRating(width: Int) {
        let currUser = UserRepository.shared.fetchUser()
        let skinType = SkinTypesRepository.shared.fetchSkinType(id: Int(truncating: currUser.skinTypeId))
        
        ratedByLabel.text = "rated by \(skinType.title?.lowercased() ?? "") people"
        ratedByLabel.sizeToFit()
        
        ratedByLabel.snp.updateConstraints { make in
            make.height.equalTo(ratedByLabel.requiredHeight)
        }
        
        ratingView.snp.updateConstraints { make in
            make.width.equalTo(width)
        }
        
        UIView.animate(withDuration: 0.2) {
            self.ratedByLabel.alpha = 1
        }
        layoutSubviews()
    }
}
