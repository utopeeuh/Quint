//
//  UsageGuideVC.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 14/11/22.
//

import Foundation
import UIKit
import SnapKit

class UsageGuideVC: UIViewController{
    
    var categoryId : Int!
    private let viewTitle = UILabel()
    private let backBtn = UIButton(type: .custom)
    private let categoryLabel = UILabel()
    
    private var currCategory : CategoryModel?
    private var usageSteps : [UsageStepModel] = []
    
    private var buttons: [CollapsableButton] = []
    private var collapsableStack = CollapsableStack()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        currCategory = CategoriesRepository.shared.fetchCategory(id: categoryId)
        usageSteps = UsageStepsRepository.shared.fetchUsageSteps(categoryId: categoryId)

        configureUI()
    }
    
    override func configureComponents() {
        view.backgroundColor = K.Color.bgQuint
        
        viewTitle.font = .interMedium(size: 16)
        viewTitle.text = currCategory?.title ?? "Error loading"
        viewTitle.text! += " guide"

        backBtn.setImage(UIImage(named: "arrow_back"), for: .normal)
        backBtn.setTitle("", for: .normal)
        backBtn.sizeToFit()
        backBtn.addTarget(self, action: #selector(backOnClick), for: .touchUpInside)
        
        categoryLabel.text = viewTitle.text
        categoryLabel.font = .clashGroteskMedium(size: 30)
        
        var i = 1
        usageSteps.forEach { usageStep in
            let button = CollapsableButton(title: usageStep.title ?? "", desc: usageStep.desc ?? "")
            button.setNumber(i)
            button.headerBtn.addTarget(self, action: #selector(onClickExpand), for: .touchUpInside)
            
            collapsableStack.append(button)
            
            i += 1
        }
    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: backBtn, viewTitle, categoryLabel, collapsableStack)
        
        backBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(11)
            make.size.equalTo(24)
        }
        
        viewTitle.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn)
            make.centerX.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(viewTitle.snp.bottom).offset(37)
        }
        
        collapsableStack.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.top.equalTo(categoryLabel.snp.bottom).offset(24)
            make.height.equalTo(collapsableStack.getHeight())
        }
    }
    
    @objc func backOnClick(){
        navigationController?.popViewController(animated: true)
    }
}

extension UsageGuideVC: CollapsableStackDelegate{
    func onClickExpand(_ sender: UIButton) {
        if let collapsable = sender.superview as? CollapsableButton{
            collapsableStack.showView(collapsable)
        }
    }
}
