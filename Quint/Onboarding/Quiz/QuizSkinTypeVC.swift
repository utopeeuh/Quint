//
//  QuizSkinTypeVC.swift
//  Quint
//
//  Created by Vendly on 05/10/22.
//

import UIKit
import SnapKit

protocol QuizSkinTypeProtocol {
    func checkQuizStatus()
}

class QuizSkinTypeVC: UIViewController {
    
    private let backBtn: UIButton = {
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow_back"), for: .normal)
        
        return button
        
    }()
    
    private let progressBar: UIProgressView = {
        
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        progressView.progressTintColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
        progressView.setProgress(0.16, animated: true)
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        
        return progressView
        
    }()
    
    private let skinTypeLbl: UILabel = {
        
        let label = UILabel()
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.text = "What is your skin type?"
        label.font = .clashGroteskMedium(size: 30)
        label.textAlignment = .left
        return label
        
    }()
    
    private let skinTypetableView: UITableView = {
        
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
        
        nextBtn.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        
        skinTypetableView.delegate = self
        skinTypetableView.dataSource = self
        skinTypetableView.separatorColor = .clear
        
        skinTypetableView.register(QuizSkinTypeCell.self, forCellReuseIdentifier: QuizSkinTypeCell.id)
        
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
    
    @objc func buttonViewOnClick(_ sender: UISwitch) {
        
    }
    
    @objc func didTapNext() {
        let controller = QuizSkinCondVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func skinTypeOnClick(_ sender: UITapGestureRecognizer){
        print("Tapped!")
    }

}

extension QuizSkinTypeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: QuizSkinTypeCell.id,
            for: indexPath) as? QuizSkinTypeCell else {
                return UITableViewCell()
            }
        cell.textLabel?.text = "This skin is neither too dry nor too oily. It has regular texture, no imperfections and a clean, soft appearance, and does not need special care."
        cell.backgroundColor = .clear
        cell.textLabel?.numberOfLines = 3
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
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(skinTypeOnClick))
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 66))
        headerView.backgroundColor = K.Color.bgQuint
        
        let view = UIView()
        view.frame = CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 52)
        view.backgroundColor = .white
//        view.layer.borderWidth = 1.5
//        view.layer.borderColor = CGColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
        view.layer.cornerRadius = 8
        view.addGestureRecognizer(gesture)
        
        let label = UILabel()
        label.frame = CGRect.init(x: 10, y: 0, width: headerView.frame.width - 10, height: headerView.frame.height - 16)
        
//        if gesture.state == .began {
            view.layer.borderWidth = 1.5
            view.layer.borderColor = CGColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
            label.textColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
            label.font = .interSemiBold(size: 16)
//        } else {
//            label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
//            label.font = .interMedium(size: 16)
//        }
        
        let borderView = UIView()
        borderView.frame = CGRect.init(x: 0, y: 52, width: tableView.frame.height, height: 14)
        borderView.backgroundColor = K.Color.bgQuint
        
        if section == 0 {
            label.text = "Normal skin"
        } else if section == 1 {
            label.text = "Dry skin"
        } else if section == 2 {
            label.text = "Oily skin"
        } else {
            label.text = "Combination skin"
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

extension QuizSkinTypeVC: QuizSkinTypeProtocol {

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
