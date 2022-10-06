//
//  IngredientListView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/10/22.
//

import UIKit

class IngredientListView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var topScrollCategories = HorizontalScrollButtons()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
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
        
        // Generate buttons before adding to scrollview
        var topCatButtons: [SmallCategoryButton] = []
        
        for ing in K.Category.ingredient {
            let newBtn = SmallCategoryButton(categoryId: ing.key)
            newBtn.setText(ing.value)
            newBtn.addTarget(self, action: #selector(selectTopCategory), for: .touchUpInside)
            topCatButtons.append(newBtn)
        }
        topScrollCategories.setButtons(topCatButtons)
    }
    
    func configureLayout(){
        addSubview(topScrollCategories)
        topScrollCategories.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(80)
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

}
