//
//  dummyVC.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 12/10/22.
//

import Foundation
import UIKit
import SnapKit

class DummyVC: UIViewController{
    
    var allergy = AllergenCell("Contains tea tree oil")
    var usage = UsageCell("Avoid using with hyaluronic acid")
    var safety = SafetyCell()
    var sens = SensitivityCell("None")
    var source = SourceCell("https://www.innisfree.com/id/en/product/productView.do?prdSeq=31641&catCd01=UA")
    
    var testingStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func configureComponents() {
        view.backgroundColor = K.Color.bgQuint
        testingStack.axis = .vertical
        testingStack.spacing = 20
//        testingStack.translatesAutoresizingMaskIntoConstraints = false
        
        testingStack.addArrangedSubview(allergy)
        testingStack.addArrangedSubview(usage)
        testingStack.addArrangedSubview(sens)
        testingStack.addArrangedSubview(safety)
        testingStack.addArrangedSubview(source)
    }
    
    override func configureLayout() {
        view.addSubview(testingStack)
        testingStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).offset(-40)
            make.centerX.equalToSuperview()
        }
    }
}
