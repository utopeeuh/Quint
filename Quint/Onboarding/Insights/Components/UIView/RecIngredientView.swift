//
//  RecIngredientView.swift
//  Quint
//
//  Created by Vendly on 19/10/22.
//

import UIKit
import SnapKit

class RecIngredientView: UIView {
    
    private var titleLabel = UILabel()
    private var skinProblemScrollCategories = HorizontalScrollButtons()
    private var ingredientScrollList = HorizontalScrollButtons()
    
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

    func configureComponents() {

        self.backgroundColor = K.Color.bgQuint
        self.layer.shadowColor = K.Color.greyQuint.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0.2, height: 0.3)
        self.layer.cornerRadius = 10
        
        titleLabel.font = .clashGroteskMedium(size: 20)
        titleLabel.text = "Recommended ingredients"
        titleLabel.textColor = K.Color.blackQuint
        
        // Generate buttons before adding to scrollview
        var skinProblemButton: [SmallCategoryButton] = []
        for i in 0..<K.Category.ingredient.count {
            let newButton = SmallCategoryButton(categoryId: i+1)
            newButton.setText(K.Category.ingredient[i+1])
            newButton.addTarget(self, action: #selector(selectSkinProblemCategory), for: .touchUpInside)
            skinProblemButton.append(newButton)
        }
        skinProblemScrollCategories.setButtons(skinProblemButton)
        selectSkinProblemCategory(skinProblemButton[0])
        
        var ingredientButtons: [IngredientButton] = []
        
        for i in 0..<K.Dummy.ingredient.count {
            let newButton = IngredientButton(categoryId: i+1)
            newButton.setText(K.Dummy.ingredient[i+1])
            newButton.addTarget(self, action: #selector(goToIngredientDetail), for: .touchUpInside)
            ingredientButtons.append(newButton)
        }
        ingredientScrollList.setButtons(ingredientButtons)
        
    }
    
    func configureLayout() {

        multipleSubviews(view: titleLabel,
                               skinProblemScrollCategories,
                               ingredientScrollList)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
            make.top.equalToSuperview().offset(28)
        }
        
        skinProblemScrollCategories.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }

        ingredientScrollList.snp.makeConstraints { make in
            make.top.equalTo(skinProblemScrollCategories.snp.bottom).offset(28)
            make.width.equalToSuperview()
            make.height.equalTo(88)
        }
        
    }
    
    @objc func selectSkinProblemCategory(_ sender: SmallCategoryButton) {
        for view in skinProblemScrollCategories.subviews as [UIView] {
            if let btn = view as? SmallCategoryButton {
                btn.deselect()
            }
        }
        sender.select()
    }
    
    @objc func goToIngredientDetail (_ sender: IngredientButton){
        
    }
    
}
