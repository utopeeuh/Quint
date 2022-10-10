//
//  QuizSkinLogVC.swift
//  Quint
//
//  Created by Vendly on 08/10/22.
//

import UIKit
import SnapKit

class QuizSkinLogVC: UIViewController {
    
    private let backBtn: UIButton = {
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow_back"), for: .normal)
        
        return button
        
    }()
    
    private let progressBar: UIProgressView = {
        
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        progressView.progressTintColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
        progressView.setProgress(0.64, animated: true)
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        
        return progressView
        
    }()
    
    private let skinLogLbl: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.text = "Let's take your first skin log selfie"
        label.font = .clashGroteskMedium(size: 30)
        label.textAlignment = .center
        return label
        
    }()
    
    private let skinLogCaptionLbl: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.text = "This skin log will mark the first day of your skin condition journey."
        label.font = .interRegular(size: 16)
        label.textAlignment = .center
        return label
        
    }()
    
    private let skinLogLogo: UIImageView = {
       
        let imgLogo = UIImageView()
        imgLogo.image = UIImage(named: "face_logo")
        return imgLogo
        
    }()
    
    private let takePhotoBtn: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Take Photo", for: .normal)
        button.titleLabel?.font = .clashGroteskMedium(size: 18)
        
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        button.setTitleColor(UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1), for: .normal)
        
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowColor = UIColor(red: 16/255, green: 24/255, blue: 40/255, alpha: 0.05).cgColor
        button.layer.shadowOpacity = 5.0
        
        return button
        
    }()
    
    private let skipBtn: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = .clashGroteskMedium(size: 18)
        
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
        button.setTitleColor(UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1), for: .normal)
        
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1).cgColor
        
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
        
        takePhotoBtn.addTarget(self, action: #selector(didTapPhoto), for: .touchUpInside)
        skipBtn.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        
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
        
        view.addSubview(skinLogLbl)
        skinLogLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressBar.snp.bottom).offset(70)
            make.width.equalToSuperview().offset(-40)
        }
        
        view.addSubview(skinLogCaptionLbl)
        skinLogCaptionLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(skinLogLbl.snp.bottom).offset(14)
            make.width.equalToSuperview().offset(-40)
        }
        
        view.addSubview(skinLogLogo)
        skinLogLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(skinLogCaptionLbl.snp.bottom).offset(56)
        }
        
        view.addSubview(takePhotoBtn)
        takePhotoBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-124)
            make.width.equalToSuperview().offset(-40)
        }
        
        view.addSubview(skipBtn)
        skipBtn.snp.makeConstraints { make in
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
    
    @objc func didTapPhoto() {
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
        
        let controller = PhotoConfirmationVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func didTapNext() {
        let controller = QuizNotifVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension QuizSkinLogVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
//        guard let image = info[UIImagePickerController.InfoKey.originalImage] as?
//                UIImage else {
//            return
//        }
        
    }
    
}
