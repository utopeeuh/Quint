//
//  QuizSkinInsightVC.swift
//  Quint
//
//  Created by Vendly on 08/10/22.
//

import UIKit
import SnapKit

class QuizSkinInsightVC: UIViewController {
    
    private let backBtn: UIButton = {
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow_back"), for: .normal)
        
        return button
        
    }()
    
    private let progressBar: UIProgressView = {
        
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        progressView.progressTintColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
        progressView.setProgress(1.0, animated: true)
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        
        return progressView
        
    }()
    
    private let seeInsightsLbl: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.text = "We got your skin insights & recommendation ready!"
        label.font = .clashGroteskMedium(size: 30)
        label.textAlignment = .center
        return label
        
    }()
    
    private let seeInsightsCaptionLbl: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.text = "Quint has prepared you a brief skin analysis result and personalized recommendation for your current skin condition"
        label.font = .interRegular(size: 16)
        label.textAlignment = .center
        return label
        
    }()
    
    private let seeInsightsLogo: UIImageView = {
       
        let imgLogo = UIImageView()
        imgLogo.image = UIImage(named: "receipt_logo")
        return imgLogo
        
    }()
    
    private let seeInsightsBtn: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("See insights", for: .normal)
        button.titleLabel?.font = .clashGroteskMedium(size: 18)
        
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        button.setTitleColor(UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1), for: .normal)
        
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowColor = UIColor(red: 16/255, green: 24/255, blue: 40/255, alpha: 0.05).cgColor
        button.layer.shadowOpacity = 5.0
        
        return button
        
    }()
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
//        seeInsightsBtn.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        
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
        
        view.addSubview(seeInsightsLbl)
        seeInsightsLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressBar.snp.bottom).offset(70)
            make.width.equalToSuperview().offset(-40)
        }
        
        view.addSubview(seeInsightsCaptionLbl)
        seeInsightsCaptionLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(seeInsightsLbl.snp.bottom).offset(14)
            make.width.equalToSuperview().offset(-40)
        }
        
        view.addSubview(seeInsightsLogo)
        seeInsightsLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(seeInsightsCaptionLbl.snp.bottom).offset(56)
        }
        
        view.addSubview(seeInsightsBtn)
        seeInsightsBtn.snp.makeConstraints { make in
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
    
//    @objc func didTapNext() {
//        let controller =
//        navigationController?.pushViewController(controller, animated: true)
//    }
    
}
