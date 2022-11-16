//
//  IngredientCategoryDetail.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 11/10/22.
//

import Foundation
import UIKit
import SnapKit

class IngredientCategoryDetailVC: UIViewController{
    
    var effect: EffectModel?
    
    private let viewTitle = UILabel()
    private let backBtn = UIButton(type: .custom)
    
    private var catImageView: UIImageView!
    private var catNameLabel = UILabel()
    private var catDescLabel = UILabel()
    private var ingredientList : [IngredientModel] = []
    private var ingredientCollection = IngredientListCollectionView()
    private var bottomView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        view.backgroundColor = K.Color.whiteQuint
        
        ingredientList = IngredientsRepository.shared.fetchIngredientList(effect: effect?.title ?? "")
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func configureComponents() {
        
        viewTitle.font = .interMedium(size: 16)
        viewTitle.text = (effect?.title ?? "Error") + " ingredients"

        backBtn.setImage(UIImage(named: "arrow_back"), for: .normal)
        backBtn.setTitle("", for: .normal)
        backBtn.sizeToFit()
        backBtn.addTarget(self, action: #selector(backOnClick), for: .touchUpInside)
        
        catImageView = UIImageView(image: K.CategoryImage.ingredient[Int(truncating: effect?.id ?? 1)] as? UIImage)
        
        catNameLabel.text = effect?.title
        catNameLabel.font = .clashGroteskMedium(size: 30)
        
        catDescLabel.text = effect?.desc
        catDescLabel.font = .interMedium(size: 16)
        catDescLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width-40, height: catDescLabel.requiredHeight)
        catDescLabel.numberOfLines = 0
        catDescLabel.lineBreakMode = .byWordWrapping
        
        ingredientCollection.setSource(ingredientList)
        
        bottomView.backgroundColor = K.Color.bgQuint
    }
    
    override func configureLayout() {
        view.multipleSubviews(view: backBtn, viewTitle, catImageView, catNameLabel, catDescLabel, bottomView, ingredientCollection)
        
        backBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(11)
            make.size.equalTo(24)
        }
        
        viewTitle.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn)
            make.centerX.equalToSuperview()
        }
        
        catImageView.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.bottom).offset(37)
            make.height.width.equalTo(52)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        catNameLabel.snp.makeConstraints { make in
            make.top.equalTo(catImageView.snp.bottom).offset(24)
            make.left.right.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(36)
        }
        
        catDescLabel.snp.makeConstraints { make in
            make.top.equalTo(catNameLabel.snp.bottom).offset(12)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(catDescLabel.requiredHeight)
        }
        
        ingredientCollection.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.top).offset(20)
            make.width.equalTo(bottomView).offset(-40)
            make.centerX.equalTo(bottomView)
            make.bottom.equalTo(bottomView)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(catDescLabel.snp.bottom).offset(28)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc func backOnClick(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func text(){
        print("DDD")
    }
}
