//
//  OnboardingResultVC.swift
//  Quint
//
//  Created by Vendly on 17/10/22.
//

import UIKit
import SnapKit

class OnboardingResultVC: UIViewController {
    
    private var insightResult = InsightResult()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func configureLayout() {
        view.addSubview(insightResult)
        insightResult.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
    
}
