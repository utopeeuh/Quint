//
//  CollapsableButton.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 19/10/22.
//

import Foundation
import UIKit
import SnapKit

class CollapsableButton: UIView{
    
    var headerBtn = CollapsableHeaderButton()
    var descView = UIView()
    var descText = UILabel()
    var border = UIView()
    
    required init(title: String, desc: String) {
        super.init(frame: .zero)
        
        configureComponents()
        
        headerBtn.setTitle(title, for: .normal)
        headerBtn.titleLabel!.sizeToFit()
        
        descText.text = desc
        descText.sizeToFit()
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func configureComponents(){
        
        headerBtn.addTarget(self, action: #selector(showDesc), for: .touchUpInside)
        
        descText.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 51.5, height: 0)
        descText.font = .interRegular(size: 14)
        descText.lineBreakMode = .byWordWrapping
        descText.numberOfLines = 0
        
        border.backgroundColor = K.Color.greenQuint
        
        descView.backgroundColor = K.Color.bgQuint
        descView.addSubview(descText)
        descView.addSubview(border)
        
        descView.isHidden = true
        descView.alpha = 0
    }
    
    override func configureLayout(){
        addSubview(descView)
        addSubview(headerBtn)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(headerBtn.titleLabel!.requiredHeight+28)
        }
        
        headerBtn.snp.makeConstraints { make in
            make.width.centerX.equalToSuperview()
            make.height.equalTo(headerBtn.titleLabel!.requiredHeight+28)
        }
        
        descView.snp.makeConstraints { make in
            make.top.equalTo(headerBtn.snp.bottom).offset(14)
            make.width.centerX.equalTo(headerBtn)
            make.height.equalTo(descText.requiredHeight)
        }
        
        border.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalTo(1.5)
            make.height.equalTo(descText.requiredHeight)
        }
        
        descText.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.left.equalTo(border.snp.right).offset(10)
            make.height.equalTo(descText.requiredHeight)
        }
    }
    
    @objc func showDesc(){
        descView.isHidden = false
        
        UIView.animate(withDuration: 0.4, animations: { [self] in
            descView.alpha = 1
            headerBtn.selected()
        })
    }
    
    func setNumber(_ i: Int){
        headerBtn.setNumber(i)
        
        headerBtn.snp.updateConstraints { make in
            make.height.equalTo(headerBtn.titleLabel!.requiredHeight+28)
        }
        
        descView.snp.updateConstraints { make in
            make.top.equalTo(headerBtn.snp.bottom).offset(14)
        }
        
        self.snp.updateConstraints { make in
            make.height.equalTo(headerBtn.titleLabel!.requiredHeight+28)
        }
    }
    
    func hideDesc(){
        UIView.animate(withDuration: 0.4, animations: { [self] in
            descView.alpha = 0
            headerBtn.deselect()
        }) { completion in
            self.descView.isHidden = true
        }
    }
    
    func getHiddenHeight()->CGFloat{
        return (headerBtn.titleLabel?.requiredHeight ?? 0) + 28
    }

    func getHeightDiff()->CGFloat{
        return descText.requiredHeight + 14
    }
}
