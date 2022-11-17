//
//  IngredientSegmentView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 11/10/22.
//

import Foundation
import UIKit
import SnapKit

class IngredientSegmentView: UIView{

    private var product: ProductModel?
    
    private var mainScrollView = UIScrollView()
    private var goodIngCollection = IngredientListSection()
    private var otherIngredientLabel = HeaderLabel()
    private var ingredientList = UILabel()
    
    init(product: ProductModel) {
        super.init(frame: .zero)
        self.product = product
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func configureComponents() {
        
        backgroundColor = K.Color.bgQuint
        
        let goodIngredientList = IngredientsRepository.shared.fetchIngredientList(product: product!)
        
        goodIngCollection.setSource(goodIngredientList)
        goodIngCollection.setHeader("Good for you")
        
        otherIngredientLabel.text = "Full ingredients list"
        
        ingredientList.text = product?.ingredients
        ingredientList.font = .interRegular(size: 16)
        ingredientList.textColor = K.Color.greyQuint
        ingredientList.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 0)
        ingredientList.numberOfLines = 0
        ingredientList.lineBreakMode = .byWordWrapping
    }
    
    func getTotalHeight() -> CGFloat{
        return goodIngCollection.getHeight() + otherIngredientLabel.requiredHeight + 12 + ingredientList.requiredHeight + 24
    }
    
    override func configureLayout() {
        
       addSubview(goodIngCollection)
       addSubview(otherIngredientLabel)
       addSubview(ingredientList)
        
        goodIngCollection.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(goodIngCollection.getHeight())
        }
        
        otherIngredientLabel.snp.makeConstraints { make in
            make.top.equalTo(goodIngCollection.snp.bottom).offset(24)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.height.equalTo(otherIngredientLabel.requiredHeight)
        }
        
        ingredientList.snp.makeConstraints { make in
            make.top.equalTo(otherIngredientLabel.snp.bottom)
            .offset(12)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.height.equalTo(ingredientList.requiredHeight)
        }
    }
    
    
}
