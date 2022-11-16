//
//  IngDetailLowerView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 18/10/22.
//

import Foundation
import SnapKit
import UIKit

class IngDetailLowerView: UIView{
    private var ingredient: IngredientModel?
    
    private var factLbl = HeaderLabel()
    private var factStack = UIStackView()
    private var factStackH: CGFloat = 0
    
    private var allergenLbl = HeaderLabel()
    private var allergenCell: AllergenCell!
    
    private var sensLbl = HeaderLabel()
    private var sensCell: SensitivityCell!
    
    private var usageLbl = HeaderLabel()
    private var usageCell: UsageCell!
    
    private var sourceLbl = HeaderLabel()
    private var sourceCell: SourceCell!
    
    private var totalHeight: CGFloat = 0
    
    required init(ingredient: IngredientModel) {
        super.init(frame: .zero)
        self.ingredient = ingredient
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getHeight() -> CGFloat {
        return 0
    }
    
    override func configureComponents(){
        backgroundColor = K.Color.bgQuint
        
        factLbl.text = "Quick facts"
        allergenLbl.text = "Allergen"
        sensLbl.text = "Sensitivity"
        usageLbl.text = "Usage precaution"
        sourceLbl.text = "Information resource"
        
        factStack.axis = .vertical
        factStack.spacing = 12
        
        let effectList = generateEffectList()
        
        var i = 1
        effectList.forEach { e in
            let newCell = QuickFactCell(title: e.title!, desc: e.desc!, number: i)
            factStack.addArrangedSubview(newCell)
            factStackH += QuickFactCell(title: e.title!, desc: e.desc!, number: i).getHeight()
            i += 1
        }
        factStackH += CGFloat((effectList.count-1)*12)
        
        allergenCell = AllergenCell(ingredient?.allergen ?? "")
        sensCell = SensitivityCell(ingredient?.avoidIfSens ?? true ? "Sensitive to several skin types" : "None")
        
        usageCell = UsageCell(ingredient?.usage ?? "")
        
        sourceCell = SourceCell(ingredient?.source ?? "")
        
        // Add heights and offsets
        addToHeight(factLbl.requiredHeight*5)
        addToHeight(factStackH)
        addToHeight(allergenCell.getHeight())
        addToHeight(sensCell.getHeight())
        addToHeight(usageCell.getHeight())
        addToHeight(sourceCell.linkLabel.requiredHeight+28)
        addToHeight(48*4 + 18*5)
    }
    
    override func configureLayout(){
        multipleSubviews(view: factLbl,
                               factStack,
                               allergenLbl,
                               allergenCell,
                               sensLbl,
                               sensCell,
                               usageLbl,
                               usageCell,
                               sourceLbl,
                               sourceCell)
        
        factLbl.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(factLbl.requiredHeight)
            make.width.centerX.equalToSuperview()
        }
        
        factStack.snp.makeConstraints { make in
            make.top.equalTo(factLbl.snp.bottom).offset(18)
            make.width.centerX.equalToSuperview()
        }
        
        allergenLbl.snp.makeConstraints { make in
            make.top.equalTo(factStack.snp.bottom).offset(48)
            make.height.equalTo(allergenLbl.requiredHeight)
            make.width.centerX.equalToSuperview()
        }
        
        allergenCell.snp.makeConstraints { make in
            make.top.equalTo(allergenLbl.snp.bottom).offset(18)
            make.width.centerX.equalToSuperview()
        }
        
        sensLbl.snp.makeConstraints { make in
            make.top.equalTo(allergenCell.snp.bottom).offset(48)
            make.height.equalTo(sensLbl.requiredHeight)
            make.width.centerX.equalToSuperview()
        }
        
        sensCell.snp.makeConstraints { make in
            make.top.equalTo(sensLbl.snp.bottom).offset(18)
            make.width.centerX.equalToSuperview()
        }
        
        usageLbl.snp.makeConstraints { make in
            make.top.equalTo(sensCell.snp.bottom).offset(48)
            make.height.equalTo(usageLbl.requiredHeight)
            make.width.centerX.equalToSuperview()
        }
        
        usageCell.snp.makeConstraints { make in
            make.top.equalTo(usageLbl.snp.bottom).offset(18)
            make.width.centerX.equalToSuperview()
        }
        
        sourceLbl.snp.makeConstraints { make in
            make.top.equalTo(usageCell.snp.bottom).offset(48)
            make.height.equalTo(sourceLbl.requiredHeight)
            make.width.centerX.equalToSuperview()
        }
        
        sourceCell.snp.makeConstraints { make in
            make.top.equalTo(sourceLbl.snp.bottom).offset(18)
            make.width.centerX.equalToSuperview()
        }
    }
    
    func generateEffectList() -> [EffectModel]{
        var effectList = EffectsRepository.shared.fetchEffectList()
        var newEffectList: [EffectModel] = []
        
        effectList.forEach { effect in
            print(ingredient!.effects)
            if ingredient!.effects.contains(effect.title!.lowercased()){
                newEffectList.append(effect)
            }
        }
        
        return newEffectList
    }
    
    func addToHeight(_ height: CGFloat){
        totalHeight = totalHeight + height
    }
    
    func getTotalHeight()->CGFloat{
        return totalHeight
    }
}
