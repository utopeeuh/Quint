//
//  QuizSkinTypeVC.swift
//  Quint
//
//  Created by Vendly on 05/10/22.
//

import UIKit
import SnapKit

class OnboardingQuizVC: UIViewController {

    private var scrollView = UIScrollView()
    private var skinTypeView = SkinTypeView()
    private var skinConditionView = SkinConditionView()
    private var skinProblemView = SkinProblemView()
    private var skinLogView = SkinLogView()
    private var skinNotifView = SkinNotifView()
    private var skinInsightView = SkinInsightView()
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = K.Color.bgQuint
        
        configureUI()
    }
    
    override func configureComponents() {
        scrollView.backgroundColor = K.Color.purpleQuint
        scrollView.isScrollEnabled = true
    }
    
    override func configureLayout() {
    
        view.addSubview(scrollView)
        scrollView.addSubview(skinTypeView)
        scrollView.addSubview(skinConditionView)
//        contentView.addSubview(skinProblemView)
//        contentView.addSubview(skinLogView)
//        contentView.addSubview(skinNotifView)
//        contentView.addSubview(skinInsightView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        skinTypeView.snp.makeConstraints { make in
            make.top.left.right.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }

        skinConditionView.snp.makeConstraints { make in
            make.left.equalTo(scrollView).offset(20)
            make.right.equalTo(scrollView).offset(-20)
            make.height.equalTo(40)
            make.top.equalTo(skinTypeView.snp.bottom).offset(20)
            make.bottom.equalTo(scrollView).offset(-20)
        }

//        skinProblemView.snp.makeConstraints { make in
//            make.left.equalTo(contentView).offset(20)
//            make.right.equalTo(contentView).offset(-20)
//            make.height.equalTo(40)
//            make.top.equalTo(skinConditionView.snp.bottom).offset(20)
//            make.bottom.equalTo(contentView).offset(-20)
//        }
//
//        skinLogView.snp.makeConstraints { make in
//            make.left.equalTo(contentView).offset(20)
//            make.right.equalTo(contentView).offset(-20)
//            make.height.equalTo(40)
//            make.top.equalTo(skinProblemView.snp.bottom).offset(20)
//            make.bottom.equalTo(contentView).offset(-20)
//        }
//
//        skinNotifView.snp.makeConstraints { make in
//            make.left.equalTo(contentView).offset(20)
//            make.right.equalTo(contentView).offset(-20)
//            make.height.equalTo(40)
//            make.top.equalTo(skinLogView.snp.bottom).offset(20)
//            make.bottom.equalTo(contentView).offset(-20)
//        }
//
//        skinInsightView.snp.makeConstraints { make in
//            make.left.equalTo(contentView).offset(20)
//            make.right.equalTo(contentView).offset(-20)
//            make.height.equalTo(40)
//            make.top.equalTo(skinNotifView.snp.bottom).offset(20)
//            make.bottom.equalTo(contentView).offset(-20)
//        }

    }
    
}

