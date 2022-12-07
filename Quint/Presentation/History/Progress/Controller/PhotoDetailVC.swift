//
//  PhotoDetailVC.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/12/22.
//

import Foundation
import UIKit
import SnapKit

class PhotoDetailVC: UIViewController {
    private let viewTitle : UILabel = {
        let label = UILabel()
        label.font = .interMedium(size: 16)
        label.text = "Photo detail"
        return label
    }()
    
    private let backBtn : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow_back"), for: .normal)
        button.setTitle("", for: .normal)
        button.sizeToFit()
        return button
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let deleteBtn = DeleteButton()
    
    public var log : LogModel! {
        willSet {
            imageView.image = UIImage(data: newValue.image!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func configureComponents() {
        backBtn.addTarget(self, action: #selector(backOnClick), for: .touchUpInside)
        
        deleteBtn.addTarget(self, action: #selector(deleteImageOnClick), for: .touchUpInside)
        
        view.multipleSubviews(view: backBtn, viewTitle, imageView, deleteBtn)
    }
    
    override func configureLayout() {
        backBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.size.equalTo(24)
        }
        
        viewTitle.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn)
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.bottom).offset(16)
            make.bottom.equalTo(deleteBtn.snp.top).offset(-44)
            make.width.equalToSuperview()
        }
        
        deleteBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-44)
            make.size.equalTo(deleteBtn.frame.size)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func deleteImageOnClick(){
        print("delete image")
        
        let alert = UIAlertController(title: "Are you sure you want to delete this photo? Your skin log details will still be kept.", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ [self] (UIAlertAction) in
            
            // remove from core data
            LogRepository.shared.deleteLogPhoto(log: log)
            
            navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func backOnClick(){
        navigationController?.popViewController(animated: true)
    }
}
