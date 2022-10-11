//
//  dummyVC.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 11/10/22.
//

import Foundation
import UIKit
import SnapKit

class dummyVC: UIViewController{
    //24 grotesk medium 20 | 12 inter regular 16
    var mainScrollView = UIScrollView()
    var goodIngCollection = IngredientListSection()
    var notableIngCollection = IngredientListSection()
    var otherIngredientLabel = UILabel()
    var ingredientList = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.Color.bgQuint
        configureUI()
    }
    
    override func configureComponents() {
        
        mainScrollView.showsVerticalScrollIndicator = false
        
        goodIngCollection.setSource(K.Dummy.ingredient)
        goodIngCollection.setHeader("Good for you")
        
        notableIngCollection.setSource(K.Dummy.ingredient)
        notableIngCollection.setHeader("Notable ingredients")
        
        otherIngredientLabel.text = "Other ingredients"
        otherIngredientLabel.font = .clashGroteskMedium(size: 20)
        
        ingredientList.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam, purus sit amet luctus venenatis, lectus magna fringilla urna, porttitor rhoncus dolor purus non enim praesent elementum facilisis leo, vel fringilla est"
        ingredientList.font = .interRegular(size: 16)
        ingredientList.textColor = K.Color.greyQuint
        ingredientList.frame = CGRect(x: 0, y: 0, width: view.frame.width-40, height: ingredientList.requiredHeight)
        ingredientList.numberOfLines = 0
        ingredientList.lineBreakMode = .byWordWrapping
        
        mainScrollView.addSubview(goodIngCollection)
        mainScrollView.addSubview(notableIngCollection)
        mainScrollView.addSubview(otherIngredientLabel)
        mainScrollView.addSubview(ingredientList)
        
        mainScrollView.contentSize.height = getTotalHeight()
    }
    
    func getTotalHeight() -> CGFloat{
        return goodIngCollection.getHeight() + notableIngCollection.getHeight() + 24 + otherIngredientLabel.requiredHeight + 12 + ingredientList.requiredHeight + 24
    }
    
    override func configureLayout() {
        
        view.addSubview(mainScrollView)
        
        goodIngCollection.snp.makeConstraints { make in
            make.top.width.equalTo(mainScrollView)
            make.height.equalTo(goodIngCollection.getHeight())
        }
        
        notableIngCollection.snp.makeConstraints { make in
            make.top.equalTo(goodIngCollection.snp.bottom)
            make.width.equalTo(mainScrollView)
            make.height.equalTo(notableIngCollection.getHeight())
        }
        
        otherIngredientLabel.snp.makeConstraints { make in
            make.top.equalTo(notableIngCollection.snp.bottom).offset(24)
            make.width.equalTo(mainScrollView).offset(-40)
            make.centerX.equalTo(mainScrollView)
            print(otherIngredientLabel.requiredHeight)
            make.height.equalTo(otherIngredientLabel.requiredHeight)
        }
        
        ingredientList.snp.makeConstraints { make in
            make.top.equalTo(otherIngredientLabel.snp.bottom)
            .offset(12)
            make.width.equalTo(mainScrollView).offset(-40)
            make.centerX.equalTo(mainScrollView)
            make.height.equalTo(ingredientList.requiredHeight)
        }
        
        mainScrollView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }
    
    
}
