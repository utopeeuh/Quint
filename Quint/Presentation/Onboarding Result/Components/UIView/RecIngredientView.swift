//
//  RecIngredientView.swift
//  Quint
//
//  Created by Vendly on 19/10/22.
//

import UIKit
import SnapKit
import CoreData

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

    override func configureComponents() {
        
        self.backgroundColor = K.Color.bgQuint
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 36
        self.layer.shadowOffset = CGSize(width: 0, height: 16)
        self.layer.shadowColor = K.Color.shadowQuint.cgColor
        self.layer.cornerRadius = 10
        
        ingredientScrollList.setContentOffset(CGPoint(x: -25, y: 0), animated: false)
        
        titleLabel.font = .clashGroteskMedium(size: 20)
        titleLabel.text = "Recommended ingredients"
        titleLabel.textColor = K.Color.blackQuint
    }
    
    override func configureLayout() {

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
        
        // fetch ingredient list
        let ingredientList = IngredientsRepository.shared.fetchIngredientList(effect: sender.titleLabel!.text!)
        // set ingredient list here
        var ingredientButtons: [IngredientButton] = []
        
        for i in 0..<ingredientList.count {
            let newButton = IngredientButton(id: Int(truncating: ingredientList[i].id))
            newButton.setText(ingredientList[i].name)
            newButton.addTarget(self, action: #selector(goToIngredientDetail), for: .touchUpInside)
            ingredientButtons.append(newButton)
        }
        ingredientScrollList.setButtons(ingredientButtons)
        ingredientScrollList.setContentOffset(CGPoint(x: -25, y: 0), animated: true)
        print("content size: \(ingredientScrollList.contentSize.width)")
    }
    
    @objc func goToIngredientDetail (_ sender: IngredientButton){
        
    }
    
    func getEffectIdsByProblem(problemId: Int) -> [Int]{
        var effectIds : [Int] = []
        
        if (problemId+1 == K.Problem.acne || problemId+1 == K.Problem.blackHeads){
            effectIds.append(K.Effect.antiAcne)
            effectIds.append(K.Effect.antiBacterial)
        }
        if (problemId+1 == K.Problem.darkCircles || problemId+1 == K.Problem.dullness){
            effectIds.append(K.Effect.brightening)
        }
        if (problemId+1 == K.Problem.dryness){
            effectIds.append(K.Effect.hydrating)
        }
        if (problemId+1 == K.Problem.oiliness || problemId+1 == K.Problem.dryness){
            effectIds.append(K.Effect.moisturizing)
        }
        if (problemId+1 == K.Problem.redness || problemId+1 == K.Problem.acne){
            effectIds.append(K.Effect.soothing)
        }
        
        effectIds.append(K.Effect.uvProtection)
        
        return effectIds
    }
    
    func setIngredients(problemIds: [Int]){
        
        // fetch ingredient category
        var effectList: [EffectModel] = []
        problemIds.forEach { problemId in
            let effectIds = getEffectIdsByProblem(problemId: problemId)
            let currEffectList = EffectsRepository.shared.fetchEffectList(ids: effectIds)
            currEffectList.forEach { effect in
                if(effectList.contains(effect) == false){
                    effectList.append(effect)
                }
            }
        }
        
        // set categories
        var skinProblemButton: [SmallCategoryButton] = []
        for i in 0..<effectList.count {
            let newButton = SmallCategoryButton(id: Int(truncating: effectList[i].id))
            newButton.setText(effectList[i].title)
            newButton.addTarget(self, action: #selector(selectSkinProblemCategory), for: .touchUpInside)
            skinProblemButton.append(newButton)
        }
        skinProblemScrollCategories.setButtons(skinProblemButton)
        selectSkinProblemCategory(skinProblemButton[0])
    }
    
}
