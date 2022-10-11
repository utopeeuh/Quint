//
//  IngredientListSection.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 11/10/22.
//

import Foundation
import UIKit
import SnapKit

class IngredientListSection: UIView{
    
    var sectionHeader = UILabel()
    var ingredientCollection = IngredientListCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        configureComponents()
        configureLayout()
    }
    
    func setHeader(_ text: String){
        sectionHeader.text = text
    }
    
    func setSource(_ source: [Int: String]){
        ingredientCollection.setSource(source)
    }
    
    func getHeight() -> CGFloat {
        return CGFloat(ingredientCollection.getCount()*(88+22)/2) 
    }
    
    func configureComponents(){
        backgroundColor = K.Color.bgQuint
        sectionHeader.font = .clashGroteskMedium(size: 20)
        ingredientCollection.feedCollection.isScrollEnabled = false
    }
    
    func configureLayout(){
        
        addSubview(sectionHeader)
        addSubview(ingredientCollection)
        
        sectionHeader.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        ingredientCollection.snp.makeConstraints { make in
            make.top.equalTo(sectionHeader.snp.bottom).offset(18)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-24)
        }
    }
}