//
//  IngredientCategoryDetail.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 11/10/22.
//

import Foundation
import UIKit
import SnapKit

class IngredientCategoryDetailVC: UIViewController{
    
    var catId: Int!
    
    private var catImageView: UIImageView!
    private var catNameLabel = UILabel()
    private var catDescLabel = UILabel()
    private var ingredientCollection = IngredientListCollectionView()
    private var bottomView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = K.Color.whiteQuint
        
        // dummy category ID
        catId = 1
        
        configureUI()
    }
    
    override func configureComponents() {
        catImageView = UIImageView(image: K.CategoryImage.ingredient[catId] as? UIImage)
        
        catNameLabel.text = K.Category.ingredient[catId]
        catNameLabel.font = .clashGroteskMedium(size: 30)
        
        catDescLabel.text = "Prevent and fight against acne by preventing and unclogging clogged pores"
        catDescLabel.font = .interMedium(size: 16)
        catDescLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width-40, height: catDescLabel.requiredHeight)
        catDescLabel.numberOfLines = 0
        catDescLabel.lineBreakMode = .byWordWrapping
        
        bottomView.backgroundColor = K.Color.bgQuint
        bottomView.addSubview(ingredientCollection)
    }
    
    override func configureLayout() {
        view.addSubview(catImageView)
        view.addSubview(catNameLabel)
        view.addSubview(catDescLabel)
        view.addSubview(bottomView)
        
        catImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.width.equalTo(52)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        catNameLabel.snp.makeConstraints { make in
            make.top.equalTo(catImageView.snp.bottom).offset(24)
            make.left.right.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(36)
        }
        
        catDescLabel.snp.makeConstraints { make in
            make.top.equalTo(catNameLabel.snp.bottom).offset(12)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(catDescLabel.requiredHeight)
        }
        
        ingredientCollection.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.top).offset(20)
            make.width.equalTo(bottomView).offset(-40)
            make.centerX.equalTo(bottomView)
            make.bottom.equalTo(bottomView)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(catDescLabel.snp.bottom).offset(28)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
