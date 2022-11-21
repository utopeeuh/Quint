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

protocol ProductListDelegate {
    func updateContentHeight(height: CGFloat)
}

@available(iOS 16.0, *)
class ProductListView: UIView{
    
    private let heightWithoutCollection : CGFloat = 338
    var height : CGFloat = 0
    
    let productCollection = ProductListCollectionView()
    private var productEffectScroll = HorizontalScrollButtons()
    private var usageGuideScroll = HorizontalScrollButtons()
    private var categories = K.Category.product
    private var recProductsLabel = HeaderLabel()
    private var usageGuideLabel = HeaderLabel()
    
    private var catButtons: [SmallCategoryButton] = []
    
    var delegate : ProductListDelegate?
    
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
        
        usageGuideScroll.setButtons(guideButtons)
        
        height = heightWithoutCollection
    }
    
    override func configureLayout(){
        multipleSubviews(view: usageGuideLabel, usageGuideScroll, recProductsLabel, productEffectScroll, productCollection)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
        
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
            make.width.equalToSuperview()
        }
        
        productCollection.snp.makeConstraints { make in
            make.top.equalTo(productEffectScroll.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(0)
        }
    }
    
    @objc func selectTopCategory(_ sender: SmallCategoryButton) {
        for view in productEffectScroll.subviews as [UIView] {
            if let btn = view as? SmallCategoryButton {
                btn.deselect()
            }
        }
        sender.select()
        refreshProducts(categoryId: sender.id)
    }
    
    func refreshProducts(categoryId: Int){
        let productList = ProductsRepository.shared.fetchProducts(categoryId: categoryId)
        
        productCollection.setSource(productList){ [self] in
            
            height = heightWithoutCollection + productCollection.height
            
            productCollection.snp.updateConstraints({ make in
                make.height.equalTo(productCollection.height)
            })
            
            self.snp.updateConstraints { make in
                make.height.equalTo(height)
            }
            
            delegate?.updateContentHeight(height: height)
        }
    }
    
    @objc func guideOnClick(_ sender: LargeUsageButton){
        let controller = UsageGuideVC()
        controller.categoryId = sender.id
        (superview?.superview?.next as? UIViewController)?.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func fadeIn(){
        if productCollection.source.isEmpty {
            selectTopCategory(catButtons.first!)
        }
        
        UIView.animate(withDuration: 0.2) {
            self.productCollection.alpha = 1
        }
    }
    
}
