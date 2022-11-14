//
//  AllIngredientsVC.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 10/10/22.
//

import Foundation
import UIKit
import SnapKit

class AllIngredientsVC: UIViewController{
    
    let ingredientCardView = UIView()
    let scrollView = HorizontalScrollButtons()
    let ingredientCollection = IngredientListCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = K.Color.bgQuint
        configureUI()
    }
    
    override func configureComponents() {
        var catButtons: [SmallCategoryButton] = []
        for i in 0..<K.Category.ingredient.count {
            let button = SmallCategoryButton(id: i+1)
            button.addTarget(self, action: #selector(selectTopCategory), for: .touchUpInside)
            button.setText(K.Category.ingredient[i+1])
            catButtons.append(button)
        }
        scrollView.setButtons(catButtons)
        selectTopCategory(catButtons[0])
    }
    
    override func configureLayout() {
        view.addSubview(scrollView)
        view.addSubview(ingredientCollection)
        
        scrollView.snp.makeConstraints { make in
            make.top.width.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        ingredientCollection.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-40)
            make.centerX.bottom.equalToSuperview()
            make.top.equalTo(scrollView.snp.bottom).offset(24)
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
