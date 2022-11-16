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
    
    private var effectList : [EffectModel] = []
    private var ingredientList : [IngredientModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureComponents(){
        
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
        
        
        // fetch and sort effects
        effectList = EffectsRepository.shared.fetchEffectList()
        
        // Generate buttons before adding to scrollview
        var topCatButtons: [SmallCategoryButton] = []
        for i in 0..<effectList.count {
            let newBtn = SmallCategoryButton(id: Int(truncating: effectList[i].id))
            newBtn.setText(effectList[i].title)
            newBtn.addTarget(self, action: #selector(selectTopCategory), for: .touchUpInside)
            topCatButtons.append(newBtn)
        }
        topScrollCategories.setButtons(topCatButtons)
        selectTopCategory(topCatButtons[0])
        selectTopCategory(topCatButtons[0])
        
        refreshIngredients(effect: effectList.first?.title ?? "")
        
        var largeCatButtons: [LargeEffectButton] = []
        for i in 0..<effectList.count {
            let newBtn = LargeEffectButton(id: Int(truncating: effectList[i].id))
            newBtn.effect = effectList[i]
            newBtn.addTarget(self, action: #selector(goToCategoryDetail), for: .touchUpInside)
            largeCatButtons.append(newBtn)
        }
        largeCategoryScroll.setButtons(largeCatButtons)
        
        categoryLabel.text = "Ingredient categories"
    }
    
    override func configureLayout(){
        addSubview(searchBar)
        addSubview(headerStack)
        addSubview(topScrollCategories)
        addSubview(ingredientScrollList)
        addSubview(categoryLabel)
        addSubview(largeCategoryScroll)
        
        headerStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
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
        refreshIngredients(effect: effectList[sender.id-1].title ?? "")
    }
    
    func refreshIngredients(effect: String){
        var ingredientButtons: [IngredientButton] = []
        ingredientList = IngredientsRepository.shared.fetchIngredientList(effect: effect)
        for i in 0..<ingredientList.count {
            let newBtn = IngredientButton(id: Int(truncating: ingredientList[i].id))
            newBtn.setText(ingredientList[i].name)
            newBtn.addTarget(self, action: #selector(goToIngredientDetail), for: .touchUpInside)
            ingredientButtons.append(newBtn)
        }
        
        ingredientScrollList.setButtons(ingredientButtons)
        ingredientScrollList.setContentOffset(CGPoint(x: -20, y: 0), animated: true)
    }
    
    @objc func seeMoreOnClick(_ sender: UIButton){
        let controller = AllIngredientsVC()
        controller.effectList = effectList
        (superview?.superview?.next as? UIViewController)?.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func goToCategoryDetail (_ sender: LargeEffectButton){
        let controller = IngredientCategoryDetailVC()
        controller.effect = effectList[sender.id-1]
        (superview?.superview?.next as? UIViewController)?.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func goToIngredientDetail(_ sender: IngredientButton){
        let controller = IngredientDetailVC()
        controller.ingredient = ingredientList.first(where: {$0.id == sender.id as! NSObject})
        (superview?.superview?.next as? UIViewController)?.navigationController?.pushViewController(controller, animated: true)
    }

}
