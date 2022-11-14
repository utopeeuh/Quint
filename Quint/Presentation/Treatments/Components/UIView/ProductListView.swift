//
//  ProductListView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/10/22.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class ProductListView: UIView{
    
    
    let productCollection = ProductListCollectionView()
    private var productEffectScroll = HorizontalScrollButtons()
    private var usageGuideScroll = HorizontalScrollButtons()
    private var categories = K.Category.product
    private var recProductsLabel = HeaderLabel()
    private var usageGuideLabel = HeaderLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureComponents(){
        
        // Fade in collection view
        productCollection.alpha = 0
        
        // Create labels
        usageGuideLabel.text = "Product usage guides"
        recProductsLabel.text = "Recommended products"
        
        // Generate buttons for filter category scroll and guide scroll
        var catButtons: [SmallCategoryButton] = []
        var guideButtons: [LargeUsageButton] = []
        for i in 0..<categories.count {
            
            // Generate filter category buttons
            let catBtn = SmallCategoryButton(id: i+1)
            catBtn.addTarget(self, action: #selector(selectTopCategory), for: .touchUpInside)
            catBtn.setText(categories[i+1])
            catButtons.append(catBtn)
            
            // Generate guide buttons
            let guideButton = LargeUsageButton(id: i+1)
            guideButton.addTarget(self, action: #selector(guideOnClick), for: .touchUpInside)
            guideButtons.append(guideButton)
        }
        
        productEffectScroll.setButtons(catButtons)
        selectTopCategory(catButtons[0])
        
        // Select for the second time fixes layout erros, not sure why
        selectTopCategory(catButtons[0])
        
        usageGuideScroll.setButtons(guideButtons)
    }
    
    override func configureLayout(){
        multipleSubviews(view: usageGuideLabel, usageGuideScroll)
        addSubview(recProductsLabel)
        addSubview(productEffectScroll)
        addSubview(productCollection)
        
        usageGuideLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        usageGuideScroll.snp.makeConstraints { make in
            make.height.equalTo(144)
            make.top.equalTo(usageGuideLabel.snp.bottom).offset(18)
            make.width.equalToSuperview()
        }
        
        recProductsLabel.snp.makeConstraints { make in
            make.top.equalTo(usageGuideScroll.snp.bottom).offset(36)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        productEffectScroll.snp.makeConstraints { make in
            make.top.equalTo(recProductsLabel.snp.bottom).offset(16)
            make.height.equalTo(40)
            make.left.right.equalToSuperview()
        }
        
        productCollection.snp.makeConstraints { make in
            make.top.equalTo(productEffectScroll.snp.bottom).offset(36)
            make.centerX.bottom.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
        }
    }
    
    @objc func selectTopCategory(_ sender: SmallCategoryButton) {
        for view in productEffectScroll.subviews as [UIView] {
            if let btn = view as? SmallCategoryButton {
                btn.deselect()
            }
        }
        sender.select()
        print(sender.id)
    }
    
    @objc func guideOnClick(_ sender: LargeUsageButton){
        let controller = UsageGuideVC()
        controller.categoryId = sender.id
        (superview?.next as? UIViewController)?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func fadeIn(){
        UIView.animate(withDuration: 0.2) {
            self.productCollection.alpha = 1
        }
    }
    
}
