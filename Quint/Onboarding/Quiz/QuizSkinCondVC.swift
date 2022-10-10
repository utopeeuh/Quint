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
        
//        button.isEnabled = false
        
        return button
        
    }()
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        skinCondtableView.delegate = self
        skinCondtableView.dataSource = self
        skinCondtableView.separatorColor = .clear
        
        skinCondtableView.register(QuizSkinCondCell.self, forCellReuseIdentifier: QuizSkinCondCell.id)
        nextBtn.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        
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
        cell.textLabel?.text = "Sensitive skin is more prone to react to stimuli to which normal skin has no reaction. It is a fragile skin, usually accompanied by feelings of discomfort, such as heat, tightness, redness or itching."
        cell.backgroundColor = .clear
        cell.textLabel?.numberOfLines = 5
        cell.textLabel?.font = .interRegular(size: 14)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.skinTypeOnClick(_:)))
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 66))
        headerView.backgroundColor = K.Color.bgQuint
        
        let view = UIView()
        view.frame = CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 52)
        view.backgroundColor = .white
        view.layer.borderWidth = 1.5
        view.layer.borderColor = CGColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
        view.layer.cornerRadius = 8
        view.addGestureRecognizer(gesture)
        
        let label = UILabel()
        label.frame = CGRect.init(x: 10, y: 0, width: headerView.frame.width-10, height: headerView.frame.height-16)
        label.tintColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
        label.font = .interMedium(size: 16)
        
        let borderView = UIView()
        borderView.frame = CGRect.init(x: 0, y: 52, width: tableView.frame.height, height: 14)
        borderView.backgroundColor = K.Color.bgQuint
        
        if section == 0 {
            label.text = "Yes"
        } else {
            label.text = "No"
        }

        headerView.addSubview(view)
        headerView.addSubview(label)
        headerView.addSubview(borderView)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
         let footerView = UIView()
         footerView.backgroundColor = view.backgroundColor
         return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
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
