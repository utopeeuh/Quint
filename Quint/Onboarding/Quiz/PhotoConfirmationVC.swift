//
//  SkinPhotoCameraVC.swift
//  Quint
//
//  Created by Vendly on 09/10/22.
//

import UIKit
import SnapKit

class PhotoConfirmationVC: UIViewController {
    
    private let backBtn: UIButton = {
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow_back"), for: .normal)
        
        return button
        
    }()
    
    private let photoConfirmLbl: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.text = "Photo confirmation"
        label.font = .interMedium(size: 16)
        label.textAlignment = .center
        return label
        
    }()
    
    private let photoFrameImg: UIImageView = {
        
        let image = UIImageView()
        
        image.backgroundColor = .secondarySystemBackground
        image.autoresizingMask = [.flexibleTopMargin, .flexibleHeight, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleWidth]
        image.contentMode = .scaleAspectFit
        
        return image
        
    }()
    
    private let cancelBtn: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = .clashGroteskMedium(size: 18)
        
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
        button.setTitleColor(UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1), for: .normal)
        
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1).cgColor
        
        return button
        
    }()
    
    private let photoConfirmBtn: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Confirm photo", for: .normal)
        button.titleLabel?.font = .clashGroteskMedium(size: 18)
        
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        button.setTitleColor(UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1), for: .normal)
        
        return button
        
    }()
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn.addTarget(self, action: #selector(didTapPhoto), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        cancelBtn.addTarget(self, action: #selector(didTapPhoto), for: .touchUpInside)
        photoConfirmBtn.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        
        view.backgroundColor = K.Color.bgQuint
        
        configureUI()
    }
    
    override func configureLayout() {
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }

        view.addSubview(photoConfirmLbl)
        photoConfirmLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.right.equalTo(backBtn).offset(44)
            make.top.equalToSuperview().offset(65)
        }
        
        view.addSubview(photoFrameImg)
        photoFrameImg.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(photoConfirmLbl.snp.bottom).offset(16)
            make.height.equalTo(569)
        }
        
        view.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.top.equalTo(photoFrameImg.snp.bottom).offset(44)
            make.width.equalTo(170)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(photoConfirmBtn)
        photoConfirmBtn.snp.makeConstraints { make in
            make.top.equalTo(photoFrameImg.snp.bottom).offset(44)
            make.width.height.equalTo(cancelBtn)
            make.left.equalTo(cancelBtn.snp.right).offset(10)
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
        
        let controller = QuizNotifVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func didTapConfirm() {
        let controller = QuizNotifVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension PhotoConfirmationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as?
                UIImage else {
            return
        }
        
        photoFrameImg.image = image
        
    }
    
}
