//
//  OnboardingParentView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 17/10/22.
//

import Foundation
import UIKit
import SnapKit

class OnboardingParentView: UIView{
    
    var currQuizVC: OnboardingQuizVC!
    var currResultVC: OnboardingResultVC!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setQuizVC(_ vc: OnboardingQuizVC) {
        self.currQuizVC = vc
    }
    
    func setResultVC(_ vc: OnboardingResultVC) {
        self.currResultVC = vc
    }
    
    @objc func nextOnClick(){
        currQuizVC.nextOnClick()
    }
}
