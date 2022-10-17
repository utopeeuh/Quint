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
    var currVC: OnboardingQuizVC!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setVC(_ vc: OnboardingQuizVC){
        self.currVC = vc
    }
    
    @objc func nextOnClick(){
        currVC.nextOnClick()
    }
}
