//
//  IngDetailLowerView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 18/10/22.
//

import Foundation
import SnapKit
import UIKit

struct DummyFact{
    var title: String!
    var desc: String!
}

class IngDetailLowerView: UIView{
    private var ingredientId: Int!
    
    private var factLbl = HeaderLabel()
    private var facts: [DummyFact] = []
    private var factStack = UIStackView()
    private var factStackH: CGFloat = 0
    
    private var allergenLbl = HeaderLabel()
    private var allergens: [String] = []
    private var allergenStack = UIStackView()
    private var allergenStackH: CGFloat = 0
    
    private var sensLbl = HeaderLabel()
    private var sensCell: SensitivityCell!
    
    private var usageLbl = HeaderLabel()
    private var usageCell: UsageCell!
    
    private var sourceLbl = HeaderLabel()
    private var sourceCell: SourceCell!
    
    private var totalHeight: CGFloat = 0
    
    required init(id: Int) {
        super.init(frame: .zero)
        ingredientId = id
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getHeight() -> CGFloat {
        return 0
    }
    
    func configureUI(){
        configureComponents()
        configureLayout()
    }
    
    func configureComponents(){
        backgroundColor = K.Color.bgQuint
        
        factLbl.text = "Quick facts"
        allergenLbl.text = "Allergen"
        sensLbl.text = "Sensitivity"
        usageLbl.text = "Usage precaution"
        sourceLbl.text = "Information resource"
        
        factStack.axis = .vertical
        factStack.spacing = 12
        
        facts = [DummyFact(title: "Anti-acne", desc: "Prevent and fight against acne by preventing and unclogging clogged pores"), DummyFact(title: "Anti-aging", desc: "Slows your skin aging, reduce age spots, or prevent wrinkles")]
        
        for f in 0..<facts.count {
            let newCell = QuickFactCell(title: facts[f].title, desc: facts[f].desc, number: f+1)
            factStack.addArrangedSubview(newCell)
            factStackH += QuickFactCell(title: facts[f].title, desc: facts[f].desc, number: f+1).getHeight()
        }
        factStackH += CGFloat((facts.count-1)*12)
        
        allergenStack.axis = .vertical
        allergenStack.spacing = 12
        
        allergens = ["Contains tea tree oil", "Allergic to bees"]
        for a in allergens {
            let newCell = AllergenCell(a)
            allergenStack.addArrangedSubview(newCell)
            allergenStackH += AllergenCell(a).getHeight()
        }
        allergenStackH += CGFloat((allergens.count-1)*12)
        
        sensCell = SensitivityCell("Sensitive to several skin types")
        usageCell = UsageCell("Avoid using with hyaluronic acid")
        sourceCell = SourceCell("https://www.innisfree.com/id/en/product/productView.do?prdSeq=31641&catCd01=UA")
        
        // Add heights and offsets
        addToHeight(factLbl.requiredHeight*5)
        addToHeight(allergenStackH)
        addToHeight(factStackH)
        addToHeight(sensCell.getHeight())
        addToHeight(usageCell.getHeight())
        addToHeight(sourceCell.linkLabel.requiredHeight+28)
        addToHeight(48*4 + 18*5)
    }
    
    func configureLayout(){
        addSubview(factLbl)
        addSubview(factStack)
        addSubview(allergenLbl)
        addSubview(allergenStack)
        addSubview(sensLbl)
        addSubview(sensCell)
        addSubview(usageLbl)
        addSubview(usageCell)
        addSubview(sourceLbl)
        addSubview(sourceCell)
        
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
        
        allergenStack.snp.makeConstraints { make in
            make.top.equalTo(allergenLbl.snp.bottom).offset(18)
            make.width.centerX.equalToSuperview()
        }
        
        sensLbl.snp.makeConstraints { make in
            make.top.equalTo(allergenStack.snp.bottom).offset(48)
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
    
    func addToHeight(_ height: CGFloat){
        totalHeight = totalHeight + height
    }
    
    func getTotalHeight()->CGFloat{
        return totalHeight
    }
}
