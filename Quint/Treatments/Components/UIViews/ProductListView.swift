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
    private var scrollView = HorizontalScrollButtons()
    private var categories = K.Category.product
    private var topLabel = UILabel()
    
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
    
    func configureComponents(){
        topLabel.text = "Recommended products"
        topLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        // Generate buttons for top scroll
        var catButtons: [SmallCategoryButton] = []
        for i in 0..<categories.count {
            let button = SmallCategoryButton(categoryId: i+1)
            button.addTarget(self, action: #selector(selectTopCategory), for: .touchUpInside)
            button.setText(categories[i+1])
            catButtons.append(button)
        }
        scrollView.setButtons(catButtons)
    }
    
    func configureLayout(){
        addSubview(topLabel)
        addSubview(scrollView)
        addSubview(productCollection)
        
        topLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(16)
            make.height.equalTo(60)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        productCollection.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(K.Offset.sm)
            make.centerX.bottom.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
        }
    }
    
    @objc func selectTopCategory(_ sender: SmallCategoryButton) {
        for view in scrollView.subviews as [UIView] {
            if let btn = view as? SmallCategoryButton {
                btn.deselect()
            }
        }
        sender.select()
    }
}
