//
//  QuizSkinProblemVC.swift
//  Quint
//
//  Created by Vendly on 08/10/22.
//

import Foundation
import UIKit
import SnapKit
import TTGTags

class QuizSkinProblemVC: UIViewController, TTGTextTagCollectionViewDelegate {

    var dataSource: [[String]] = []
    
    let cellLeftRightPadding: CGFloat = 32.0
    
    private let backBtn: UIButton = {

        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow_back"), for: .normal)

        return button

    }()

    private let progressBar: UIProgressView = {

        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        progressView.progressTintColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
        progressView.setProgress(0.48, animated: true)
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true

        return progressView

    }()

    private let skinProblemLbl: UILabel = {

        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.text = "What is your skin\nproblems?"
        label.font = .clashGroteskMedium(size: 30)
        label.textAlignment = .left
        return label

    }()
    
    private let skinProblemColView: TTGTextTagCollectionView = {
        
        let colView = TTGTextTagCollectionView()
        
        let tagContent = TTGTextTagStringContent()
        tagContent.textFont = .interRegular(size: 16)!
        tagContent.textColor = .black
        
        let tagStyle = TTGTextTagStyle()
        tagStyle.backgroundColor = .white
        tagStyle.cornerRadius = 8
        tagStyle.textAlignment = .center
        tagStyle.extraSpace = CGSize(width: 34, height: 20)
        
        for i in 0..<K.Category.skinProblem.count {
            tagContent.text = K.Category.skinProblem[i+1]!
            
            let textTag = TTGTextTag(content: tagContent, style: tagStyle)
            colView.addTag(textTag)
        }
        
        return colView
        
    }()
    
    private let nextBtn: UIButton = {

        let button = UIButton()

        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = .clashGroteskMedium(size: 18)

        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        button.setTitleColor(UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1), for: .normal)

//        button.isEnabled = false

        return button

    }()

    //    MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        backBtn.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)

        skinProblemColView.alignment = .left
        skinProblemColView.delegate = self
        
        skinProblemColView.reload()
        
        nextBtn.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        view.backgroundColor = K.Color.bgQuint

    }

    override func configureLayout() {

        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }

        view.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.right.equalTo(backBtn).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(7)
            make.top.equalToSuperview().offset(65)
        }

        view.addSubview(skinProblemLbl)
        skinProblemLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressBar.snp.bottom).offset(70)
            make.width.equalToSuperview().offset(-40)
        }
        
        view.addSubview(skinProblemColView)
        skinProblemColView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(skinProblemLbl.snp.bottom).offset(32)
            make.width.equalTo(350)
            make.height.equalTo(156)
        }

        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-62)
            make.width.equalToSuperview().offset(-40)
        }

    }
    
    // MARK: - Selectors

    @objc func didTapBack() -> Void {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func didTapNext() {
        let controller = QuizSkinLogVC()
        navigationController?.pushViewController(controller, animated: true)
    }

}

