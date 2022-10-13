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
    
    var mainScrollView = UIScrollView()
    private var totalHeight: CGFloat = 0
    private var allergenLabel = HeaderLabel()
    private var usageLabel = HeaderLabel()
    private var safetyLabel = HeaderLabel()
    private var sourceLabel = HeaderLabel()
    
    private var allergens: [String] = []
    private var allergenStack = UIStackView()
    private var allergenStackH: CGFloat = 0
    private var usageCell: UsageCell!
    private var safetyCell = SafetyCell()
    private var sourceCell: SourceCell!

    required init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureUI(){
        configureComponents()
        configureLayout()
    }
    
    func configureComponents(){
        allergenLabel.text = "Allergen"
        usageLabel.text = "Usage precaution"
        safetyLabel.text = "Safety precaution"
        sourceLabel.text = "Source"
        
        allergenStack.axis = .vertical
        allergenStack.spacing = 12
        
        allergens = ["Allergen 1", "Allergen 2", "Loooooooooooooooooooooooooooooooooooongggggggg"]
        for a in allergens {
            let newCell = AllergenCell(a)
            allergenStack.addArrangedSubview(newCell)
            allergenStackH = allergenStackH + AllergenCell(a).getHeight()
        }
        allergenStackH = allergenStackH + CGFloat((allergens.count-1)*12)
        
        usageCell = UsageCell("Usage")
        sourceCell = SourceCell("https://github.com/utopeeuh/Quint")
        
        // Add offsets and height
        addToHeight(allergenStackH)
        addToHeight(usageCell.getHeight())
        addToHeight(sourceCell.linkLabel.requiredHeight)
        addToHeight(safetyCell.getHeight())
        addToHeight((allergenLabel.font.pointSize+1)*4)
        addToHeight(48*3)
        addToHeight(18*4)
    }
    
    func configureLayout(){
        addSubview(allergenLabel)
        addSubview(allergenStack)
        addSubview(usageLabel)
        addSubview(usageCell)
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
        
        usageCell.snp.makeConstraints { make in
            make.top.equalTo(usageLabel.snp.bottom).offset(18)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        safetyLabel.snp.makeConstraints { make in
            make.top.equalTo(usageCell.snp.bottom).offset(48)
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
    
    func addToHeight(_ height: CGFloat){
        totalHeight = totalHeight + height
    }
    
    func getTotalHeight()->CGFloat{
        return totalHeight + 40
    }
    
}
