//
//  QuizSkinTypeVC.swift
//  Quint
//
//  Created by Vendly on 05/10/22.
//

import UIKit
import SnapKit

class OnboardingQuizVC: UIViewController {

    private var backBtn = BackButton()
    private var progressBar = UIProgressView()
    
    private var scrollView = UIScrollView()
    private var skinTypeView = SkinTypeView()
    private var skinConditionView = SkinConditionView()
    private var skinProblemView = SkinProblemView()
    private var skinLogView = SkinLogView()
    private var skinNotifView = SkinNotifView()
    private var skinInsightView = SkinInsightView()
    
    var currIndex = 0
    
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = K.Color.bgQuint
        
        configureUI()
    }
    
    override func configureComponents() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        backBtn.addTarget(self, action: #selector(backOnClick), for: .touchUpInside)
        
        scrollView.backgroundColor = K.Color.bgQuint
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width*2, height: UIScreen.main.bounds.height)
    }
    
    override func configureLayout() {
    
        view.addSubview(backBtn)
        view.addSubview(scrollView)
        scrollView.addSubview(skinTypeView)
        scrollView.addSubview(skinConditionView)
//        contentView.addSubview(skinProblemView)
//        contentView.addSubview(skinLogView)
//        contentView.addSubview(skinNotifView)
//        contentView.addSubview(skinInsightView)
        
        var multiplier: CGFloat = 0
        for view in scrollView.subviews{
            if let v = view as? OnboardingParentView{
                v.setVC(self)
                v.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                    make.top.equalTo(scrollView)
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide)
                }
                moveRight(v, multiplier)
                multiplier += 1
            }
        }
        
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom).offset(46)
            make.bottom.equalTo(view)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
//        skinTypeView.setVC(self)
//        skinTypeView.snp.makeConstraints { make in
//            make.width.equalToSuperview()
//            make.top.equalTo(scrollView)
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
//
//        skinConditionView.transform = moveRight
//        skinConditionView.setVC(self)
//        skinConditionView.snp.makeConstraints { make in
//            make.width.equalToSuperview()
//            make.top.equalTo(scrollView)
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
//        }

//        skinProblemView.snp.makeConstraints { make in

//        }
//
//        skinLogView.snp.makeConstraints { make in
//        }
//
//        skinNotifView.snp.makeConstraints { make in

//        }
//
//        skinInsightView.snp.makeConstraints { make in

//        }

    }
    
    func moveRight(_ view: UIView, _ multiplier: CGFloat){
        view.transform = CGAffineTransform(translationX: (self.view.bounds.width * multiplier), y: 0.0)
    }
    
    func nextOnClick(){
        currIndex = currIndex+1
        scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width*CGFloat(currIndex), y: 0), animated: true)
    }
    
    @objc func backOnClick(){
        if currIndex == 0{
            self.navigationController?.popViewController(animated: true)
        }
        else{
            currIndex = currIndex-1
            scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width*CGFloat(currIndex), y: 0), animated: true)
        }
    }
    
}

