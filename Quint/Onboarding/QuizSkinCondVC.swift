//
//  QuizSkinCondVC.swift
//  Quint
//
//  Created by Vendly on 06/10/22.
//

import UIKit
import SnapKit

protocol QuizSkinCondProtocol {
    func checkQuizStatus()
}

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
        progressView.setProgress(0.15, animated: true)
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        
        return progressView
        
    }()
    
    private let skinTypeLbl: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.text = "Do you have a sensitive skin condition?"
        label.font = .clashGroteskMedium(size: 30)
        label.textAlignment = .left
        return label
        
    }()
    
    private let skinTypetableView: UITableView = {
        
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 16/255, green: 24/255, blue: 40/255, alpha: 0.05)
        return tableView
        
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
        
        backBtn.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        skinTypetableView.delegate = self
        skinTypetableView.dataSource = self
        
        skinTypetableView.register(QuizSkinCondCell.self, forCellReuseIdentifier: QuizSkinCondCell.id)
        
        view.backgroundColor = K.Color.bgQuint
        
        configureUI()
    }
    
    override func configureLayout() {

        view.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(7)
            make.top.equalToSuperview().offset(65)
        }
        
        view.addSubview(skinTypeLbl)
        skinTypeLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressBar.snp.bottom).offset(70)
            make.width.equalToSuperview().offset(-40)
        }
        
        view.addSubview(skinTypetableView)
        skinTypetableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(skinTypeLbl.snp.bottom).offset(32)
            make.width.equalTo(350)
            make.height.equalTo(244)
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
    
}

extension QuizSkinCondVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: QuizSkinCondCell.id,
            for: indexPath) as? QuizSkinCondCell else {
                return UITableViewCell()
            }
        cell.textLabel?.text = "Sensitive skin is more prone to\nreact to stimuli to which normal skin has no reaction. It is a fragile\nskin, usually accompanied by feelings of\ndiscomfort, such as heat, tightness, redness or\nitching."
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Yes"
        } else {
            return "No"
        }
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Spacer"
//        if section == 0 {
//            return "This skin is neither too dry nor too oily. It has\nregular texture, no imperfections and a clean, soft\nappearance, and does not need special care."
//        } else if section == 1 {
//            return "Feeling of tightness and roughness. It may also\nacquire an ashy gray color, with occurrence of\ndesquamation, itching, redness and small cracks."
//        } else if section == 2 {
//            return "Oily skin has a porous, humid and bright\nappearance. It is caused by excessive fat\nproduction by sebaceous glands."
//        } else {
//            return "Characteristics of both dry and oily skin.\nThe area with more oil is usually the T- zone (forehead,\nnose, and chin), while the cheeks is normal or dry."
//        }
    }
    
}

extension QuizSkinCondVC: QuizSkinCondProtocol {

    func checkQuizStatus() {
//        if viewModel.quizIsTouched {
//            nextBtn.isEnabled = true
//            nextBtn.backgroundColor = UIColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
//            nextBtn.setTitleColor(UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1), for: .normal)
//        } else {
//            nextBtn.isEnabled = false
//            nextBtn.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
//            nextBtn.setTitleColor(UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1), for: .normal)
//        }
    }
    
}
