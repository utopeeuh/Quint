//
//  IngredientListView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/10/22.
//

import UIKit

class IngredientListView: UIView {

    var headerStack = UIStackView()
    var headerLabel = HeaderLabel()
    var seeMoreBtn = UIButton()
    var searchBar = UISearchBar()
    var topScrollCategories = HorizontalScrollButtons()
    
    var ingredientScrollList = HorizontalScrollButtons()
    var categoryLabel = HeaderLabel()
    var largeCategoryScroll = HorizontalScrollButtons()
    
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
        
        searchBar.layer.borderWidth = 0
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search ingredients..."
            
        headerLabel.text = "Recommended ingredients"
        
        seeMoreBtn.backgroundColor = K.Color.bgQuint
        seeMoreBtn.layer.borderWidth = 0
        seeMoreBtn.setTitle("See all", for: .normal)
        seeMoreBtn.setTitleColor(K.Color.greenQuint, for: .normal)
        seeMoreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        seeMoreBtn.contentHorizontalAlignment = .right
        seeMoreBtn.sizeToFit()
        seeMoreBtn.addTarget(self, action: #selector(seeMoreOnClick), for: .touchUpInside)
        
        headerStack.axis = .horizontal
        headerStack.alignment = .top
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        headerStack.addArrangedSubview(headerLabel)
        headerStack.addArrangedSubview(seeMoreBtn)
        
        // Generate buttons before adding to scrollview
        var topCatButtons: [SmallCategoryButton] = []
        for i in 0..<K.Category.ingredient.count {
            let newBtn = SmallCategoryButton(categoryId: i+1)
            newBtn.setText(K.Category.ingredient[i+1])
            newBtn.addTarget(self, action: #selector(selectTopCategory), for: .touchUpInside)
            topCatButtons.append(newBtn)
        }
        topScrollCategories.setButtons(topCatButtons)
        selectTopCategory(topCatButtons[0])
        
        var ingredientButtons: [IngredientButton] = []
        for i in 0..<K.Dummy.ingredient.count {
            let newBtn = IngredientButton(categoryId: i+1)
            newBtn.setText(K.Dummy.ingredient[i+1])
            newBtn.addTarget(self, action: #selector(goToIngredientDetail), for: .touchUpInside)
            ingredientButtons.append(newBtn)
        }
        ingredientScrollList.setButtons(ingredientButtons)
        
        var largeCatButtons: [LargeCategoryCard] = []
        for i in 0..<K.Category.ingredient.count {
            let newBtn = LargeCategoryCard(categoryId: i+1)
            newBtn.setText(K.Category.ingredient[i+1])
            newBtn.addTarget(self, action: #selector(goToIngredientDetail), for: .touchUpInside)
            largeCatButtons.append(newBtn)
        }
        largeCategoryScroll.setButtons(largeCatButtons)
        
        categoryLabel.text = "Ingredient categories"
    }
    
    func configureLayout(){
        addSubview(searchBar)
        addSubview(headerStack)
        addSubview(topScrollCategories)
        addSubview(ingredientScrollList)
        addSubview(categoryLabel)
        addSubview(largeCategoryScroll)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-8)
            make.width.equalToSuperview().offset(-28)
            make.centerX.equalToSuperview()
        }
        
        headerStack.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.height.equalTo(headerLabel.font.pointSize+2)
        }
        
        topScrollCategories.snp.makeConstraints { make in
            make.top.equalTo(headerStack.snp.bottom).offset(16)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }

        ingredientScrollList.snp.makeConstraints { make in
            make.top.equalTo(topScrollCategories.snp.bottom).offset(28)
            make.width.equalToSuperview()
            make.height.equalTo(88)
        }

        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(ingredientScrollList.snp.bottom).offset(50)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.height.equalTo(headerStack)
        }

        largeCategoryScroll.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(18)
            make.width.equalToSuperview()
            make.height.equalTo(164)
        }
    }
    
    @objc func selectTopCategory(_ sender: SmallCategoryButton) {
        for view in topScrollCategories.subviews as [UIView] {
            if let btn = view as? SmallCategoryButton {
                btn.deselect()
            }
        }
        sender.select()
    }
    
    @objc func seeMoreOnClick(_ sender: UIButton){
        
    }
    
    @objc func goToIngredientDetail (_ sender: IngredientButton){
        
    }

}
