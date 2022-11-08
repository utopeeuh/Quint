//
//  SkinPhotoCameraVC.swift
//  Quint
//
//  Created by Vendly on 09/10/22.
//

import UIKit
import SnapKit
import AVFoundation

class PhotoConfirmationVC: UIViewController {
    
    var chosenImage: UIImage?
    
    weak var delegate: PhotoConfirmationVCDelegate?
    
    private let backBtn: UIButton = {
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow_back"), for: .normal)
        
        return button
        
    }()
    
    private let photoConfirmLbl: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = K.Color.blackQuint
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
        button.backgroundColor = K.Color.whiteQuint
        button.setTitleColor(K.Color.greenQuint, for: .normal)
        
        button.layer.borderWidth = 1.5
        button.layer.borderColor = K.Color.greenQuint.cgColor
        
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowColor = K.Color.shadowQuint.cgColor
        button.layer.shadowOpacity = 5.0
        
        return button
        
    }()
    
    private let photoConfirmBtn: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Confirm photo", for: .normal)
        button.titleLabel?.font = .clashGroteskMedium(size: 18)
        
        button.frame = CGRect(x: 0, y: 0, width: 170, height: 50)
        button.applyGradient(colours: [K.Color.greenLightQuint, K.Color.greenQuint], locations: [0, 1], radius: 8)

        button.layer.cornerRadius = 8
        button.setTitleColor(K.Color.whiteQuint, for: .normal)
        
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowColor = K.Color.shadowQuint.cgColor
        button.layer.shadowOpacity = 5.0
        
        return button
        
    }()
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        
        cancelBtn.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        
        photoConfirmBtn.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        
        backBtn.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        
        view.backgroundColor = K.Color.bgQuint
        
        configureUI()
    }
    
    override func configureComponents() {
        photoFrameImg.image = chosenImage
        
        backBtn.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: backBtn,
                                    photoConfirmLbl,
                                    photoFrameImg,
                                    cancelBtn,
                                    photoConfirmBtn)

        photoConfirmLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(65)
        }
        
        backBtn.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerY.equalTo(photoConfirmLbl)
        }
        
        photoFrameImg.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(photoConfirmLbl.snp.bottom).offset(16)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-180)
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.top.equalTo(photoFrameImg.snp.bottom).offset(44)
            make.width.equalTo(170)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(20)
        }

        photoConfirmBtn.snp.makeConstraints { make in
            make.top.equalTo(photoFrameImg.snp.bottom).offset(44)
            make.width.height.equalTo(cancelBtn)
            make.left.equalTo(cancelBtn.snp.right).offset(10)
        }
        
    }
    
    @objc func didTapBack() {
        
        self.dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapConfirm() {
        
        delegate?.didTapConfirmButton()
        
    }
    
    @objc func didTapCancel() {
        
        delegate?.didTapCancelButton()
        
    }
    
}

