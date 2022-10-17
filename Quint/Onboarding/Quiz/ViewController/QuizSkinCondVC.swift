//
//  QuizSkinCondVC.swift
//  Quint
//
//  Created by Vendly on 06/10/22.
//

import UIKit
import SnapKit

class QuizSkinCondVC: UIViewController {
    
    private let backBtn: UIButton = {
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow_back"), for: .normal)
        
        return button
        
    }()
    
    private let progressBar: UIProgressView = {
        
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        progressView.progressTintColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
        progressView.setProgress(0.32, animated: true)
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        
        return progressView
        
    }()
    
    private let skinCondLbl: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.text = "Do you have a sensitive skin condition?"
        label.font = .clashGroteskMedium(size: 30)
        label.textAlignment = .left
        return label
        
    }()
    
    private let skinCondtableView: UITableView = {
        
        let tableView = UITableView()
        tableView.backgroundColor = K.Color.bgQuint
        return tableView
        
    }()
    
    private let nextBtn: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = .clashGroteskMedium(size: 18)
        
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        button.setTitleColor(UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1), for: .normal)
        
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowColor = UIColor(red: 16/255, green: 24/255, blue: 40/255, alpha: 0.05).cgColor
        button.layer.shadowOpacity = 5.0
        
//        button.isEnabled = false
        
        return button
        
    }()
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = K.Color.bgQuint
        
        configureUI()
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
        
        view.addSubview(skinCondLbl)
        skinCondLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressBar.snp.bottom).offset(70)
            make.width.equalToSuperview().offset(-40)
        }
        
        view.addSubview(skinCondtableView)
        skinCondtableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(skinCondLbl.snp.bottom).offset(32)
            make.width.equalTo(350)
            make.height.equalTo(500)
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
        let controller = QuizSkinProblemVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func skinTypeOnClick(_ sender:UITapGestureRecognizer){
        print("tapped!")
    }
    
}
