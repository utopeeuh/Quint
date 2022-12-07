//
//  ProgressSlideshowVC.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 08/12/22.
//

import Foundation
import UIKit
import SnapKit

enum StateProgress {
  case inital, end
}

class ProgressSlideshowVC: UIViewController {
    
    private let viewTitle : UILabel = {
        let label = UILabel()
        label.font = .interMedium(size: 16)
        label.text = "Skin progress"
        label.textColor = .white
        return label
    }()
    
    private let backBtn : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ChevronLeft"), for: .normal)
        button.sizeToFit()
        return button
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let actionBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "playButtonIcon"), for: .normal)
        return button
    }()
    
    public var logs: [LogModel] = []
    
    private var currLog : LogModel! {
        willSet {
            imageView.image = UIImage(data: newValue.image!)
        }
    }
    
    private var state : StateProgress = .inital
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        currLog = logs.first
        configureUI()
    }
    
    override func configureComponents() {
        backBtn.addTarget(self, action: #selector(backOnClick), for: .touchUpInside)
        
        actionBtn.addTarget(self, action: #selector(actionOnClick), for: .touchUpInside)
        
        view.multipleSubviews(view: backBtn, viewTitle, imageView, actionBtn)
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
            make.bottom.equalTo(actionBtn.snp.top).offset(-41)
            make.width.equalToSuperview()
        }
        
        actionBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-41)
            make.size.equalTo(56)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func actionOnClick(){
        switch state {
            case .inital:
                playProgress()
                break
            case .end:
                currLog = logs.first
                actionBtn.setImage(UIImage(named: "playButtonIcon"), for:   .normal)
                state = .inital
                break
        }
    }
    
    func playProgress(){
        
        actionBtn.setImage(UIImage(named: "replayButtonIconDisabled"), for: .normal)
        actionBtn.isEnabled = false
        
        let photoDuration = 0.5
        
        var index = 1
        _ = Timer.scheduledTimer(withTimeInterval: photoDuration, repeats: true){ [self] t in
            currLog = logs[index]
            index += 1
            if index == logs.count-1{
                t.invalidate()
            }
        }
        
        let playTime = photoDuration * Double(logs.count-1)
        DispatchQueue.main.asyncAfter(deadline: .now()+playTime){ [self] in
            actionBtn.setImage(UIImage(named: "replayButtonIcon"), for: .normal)
            actionBtn.isEnabled = true
            state = .end
        }
    }
    
    @objc func backOnClick(){
        navigationController?.popViewController(animated: true)
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}
