//
//  PrecautionSegmentView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 13/10/22.
//

import Foundation
import UIKit
import SnapKit

class PrecautionSegmentView: UIView{
    
    private var product : ProductModel!
    
    var mainScrollView = UIScrollView()
    private var totalHeight: CGFloat = 0
    private var allergenLabel = HeaderLabel()
    private var usageLabel = HeaderLabel()
    private var safetyLabel = HeaderLabel()
    private var sourceLabel = HeaderLabel()
    
    private var allergens: [String] = []
    private var allergenStack = UIStackView()
    private var allergenStackH: CGFloat = 0
    
    private var usages: [String] = []
    private var usageStack = UIStackView()
    private var usageStackH: CGFloat = 0
    
    private var safetyCell = SafetyCell()
    private var sourceCell: SourceCell!

    init(product: ProductModel) {
        super.init(frame: .zero)
        self.product = product
        generateInfo()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func configureComponents(){
        
        allergenLabel.text = "Allergen"
        usageLabel.text = "Usage precaution"
        safetyLabel.text = "Safety precaution"
        sourceLabel.text = "Source"
        
        allergenStack.axis = .vertical
        allergenStack.spacing = 12
        
        for a in allergens {
            let newCell = AllergenCell(a)
            allergenStack.addArrangedSubview(newCell)
            allergenStackH = allergenStackH + AllergenCell(a).getHeight()
        }
        allergenStackH = allergenStackH + CGFloat((allergens.count-1)*12)
        
        usageStack.axis = .vertical
        usageStack.spacing = 12
        for u in usages {
            let newCell = UsageCell(u)
            usageStack.addArrangedSubview(newCell)
            usageStackH = usageStackH + UsageCell(u).getHeight()
        }
        usageStackH = usageStackH + CGFloat((allergens.count-1)*12)
        
        sourceCell = SourceCell(product.url)
        
        // Add offsets and height
        addToHeight(allergenStackH)
        addToHeight(usageStackH)
        addToHeight(sourceCell.linkLabel.requiredHeight+28)
        addToHeight(safetyCell.getHeight())
        addToHeight((allergenLabel.font.pointSize+1)*4)
        addToHeight(48*3)
        addToHeight(18*4)
    }
    
    override func configureLayout(){
        addSubview(allergenLabel)
        addSubview(allergenStack)
        addSubview(usageLabel)
        addSubview(usageStack)
        addSubview(safetyLabel)
        addSubview(safetyCell)
        addSubview(sourceLabel)
        addSubview(sourceCell)
        
        allergenLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(allergenLabel.requiredHeight)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        allergenStack.snp.makeConstraints { make in
            make.top.equalTo(allergenLabel.snp.bottom).offset(18)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        usageLabel.snp.makeConstraints { make in
            make.top.equalTo(allergenStack.snp.bottom).offset(48)
            make.height.equalTo(usageLabel.requiredHeight)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        usageStack.snp.makeConstraints { make in
            make.top.equalTo(usageLabel.snp.bottom).offset(18)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        safetyLabel.snp.makeConstraints { make in
            make.top.equalTo(usageStack.snp.bottom).offset(48)
            make.height.equalTo(safetyLabel.requiredHeight)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        safetyCell.snp.makeConstraints { make in
            make.top.equalTo(safetyLabel.snp.bottom).offset(18)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(safetyCell.snp.bottom).offset(48)
            make.height.equalTo(sourceLabel.requiredHeight)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        sourceCell.snp.makeConstraints { make in
            make.top.equalTo(sourceLabel.snp.bottom).offset(18)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
    }
    
    func generateInfo(){
        let ingredientList = IngredientsRepository.shared.fetchIngredientList(product: product)
        ingredientList.forEach { ingredient in
            let currUsage = ingredient.usage
            let currAllergen = ingredient.allergen
            
            if !usages.contains(currUsage) && currUsage != "None" {
                usages.append(currUsage)
            }
            
            if !allergens.contains(currAllergen) && currAllergen != "None" {
                allergens.append(currAllergen)
            }
        }
        
        if usages.isEmpty {
            usages.append("None")
        }
        
        if allergens.isEmpty {
            allergens.append("None")
        }
    }
    
    func addToHeight(_ height: CGFloat){
        totalHeight = totalHeight + height
    }
    
    func getTotalHeight()->CGFloat{
        return totalHeight + 40
    }
    
}
