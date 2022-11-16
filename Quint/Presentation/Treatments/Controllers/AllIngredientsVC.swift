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
    
    private let viewTitle = UILabel()
    private let backBtn = UIButton(type: .custom)
    
    private let ingredientCardView = UIView()
    private let scrollView = HorizontalScrollButtons()
    private let ingredientCollection = IngredientListCollectionView()
    var effectList : [EffectModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.Color.bgQuint
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func configureComponents() {
        
        viewTitle.font = .interMedium(size: 16)
        viewTitle.text = "Recommended ingredients"

        backBtn.setImage(UIImage(named: "arrow_back"), for: .normal)
        backBtn.setTitle("", for: .normal)
        backBtn.sizeToFit()
        backBtn.addTarget(self, action: #selector(backOnClick), for: .touchUpInside)
        
        var catButtons: [SmallCategoryButton] = []
        for i in 0..<effectList.count {
            let button = SmallCategoryButton(id: Int(truncating: effectList[i].id))
            button.addTarget(self, action: #selector(selectTopCategory), for: .touchUpInside)
            button.setText(effectList[i].title)
            catButtons.append(button)
        }
        scrollView.setButtons(catButtons)
        selectTopCategory(catButtons[0])
        selectTopCategory(catButtons[0])
        
        refreshIngredients(effect: effectList.first?.title ?? "")
    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: backBtn, viewTitle, scrollView, ingredientCollection)
        
        backBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(11)
            make.size.equalTo(24)
        }
        
        viewTitle.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn)
            make.centerX.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.bottom).offset(33)
            make.width.equalToSuperview()
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
        refreshIngredients(effect: effectList[sender.id-1].title ?? "")
    }
    
    func refreshIngredients(effect: String){
        let ingredientList = IngredientsRepository.shared.fetchIngredientList(effect: effect)
        ingredientCollection.setSource(ingredientList)
    }
    
    @objc func backOnClick(){
        navigationController?.popViewController(animated: true)
    }
}
