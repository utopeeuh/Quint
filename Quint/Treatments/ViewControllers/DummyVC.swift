//
//  dummyVC.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 12/10/22.
//

import Foundation
import UIKit
import SMIconLabel
import SnapKit

class DummyVC: UIViewController{
    
    var ingredientId: Int!
    private var nameLbl = UILabel()
    private var descLbl = UILabel()
    private var seeMoreBtn = SMIconLabel()
    private var detailSection = UIView()
    private var descBlanket = UIView()
    
    private var descTruncHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func configureComponents() {
        view.backgroundColor = K.Color.bgQuint
        
        nameLbl.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 0)
        nameLbl.text = "Salicylic Acid"
        nameLbl.font = .clashGroteskMedium(size: 30)
        nameLbl.numberOfLines = 0
        nameLbl.lineBreakMode = .byWordWrapping
        nameLbl.sizeToFit()

        descLbl.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 0)
        descLbl.text = "I ran in the problem that this solution didnt work for me. The problem was that my image had top, bottom, trailing and leading and height constrains to its parent. The fix was to have only 'align center x' and 'align center y' contains to be available for this imageView. So the imageView can compute its own instrict size, taking the insets into count. "
        descLbl.font = .interRegular(size: 16)
        descLbl.numberOfLines = 3
        descLbl.lineBreakMode = .byTruncatingTail
        descLbl.backgroundColor = K.Color.bgQuint
        descLbl.sizeToFit()
        descTruncHeight = descLbl.bounds.height
        
        seeMoreBtn.font =  .interSemi(size: 14)
        seeMoreBtn.textColor = K.Color.greenQuint
        seeMoreBtn.textAlignment = .left
        seeMoreBtn.numberOfLines = 0
        seeMoreBtn.iconPadding = 7
        seeMoreBtn.iconPosition = (.left, .center)
        seeMoreBtn.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(seeMoreOnClick))
        seeMoreBtn.addGestureRecognizer(tap)
        
        descBlanket.backgroundColor = K.Color.bgQuint
        
        detailSection.backgroundColor = K.Color.bgQuint
        detailSection.addSubview(seeMoreBtn)
        
        collapseDesc()
    }
    
    override func configureLayout() {
        view.addSubview(nameLbl)
        view.addSubview(descLbl)
        view.addSubview(descBlanket)
        view.addSubview(detailSection)
        
        nameLbl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.height.equalTo(nameLbl.requiredHeight)
        }
        
        descLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(12)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.height.equalTo(descTruncHeight)
        }
        
        descBlanket.snp.makeConstraints { make in
            make.top.equalTo(descLbl.snp.top).offset(descTruncHeight)
            make.width.centerX.equalTo(descLbl)
            make.height.equalTo(descLbl.requiredHeight-descTruncHeight)
        }
        
        detailSection.snp.makeConstraints { make in
            make.top.equalTo(descLbl.snp.top).offset(descTruncHeight)
            make.width.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        seeMoreBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.width.equalTo(86)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(seeMoreBtn.requiredHeight)
        }
    }
    
    @objc func seeMoreOnClick(sender: UITapGestureRecognizer){
        if(descLbl.bounds.height < descLbl.requiredHeight){
            expandDesc()
            return
        }
        collapseDesc()
    }
    
    func expandDesc(){
        descLbl.numberOfLines = 0
        descLbl.snp.remakeConstraints { make in
            make.top.equalTo(self.nameLbl.snp.bottom).offset(12)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.height.equalTo(descLbl.requiredHeight)
        }
        
        UIView.animate(withDuration: 0.4, animations: { [self] in
            detailSection.transform = CGAffineTransform(translationX: 0, y: descLbl.requiredHeight-descTruncHeight)
            
            descBlanket.alpha = 0
        })
        
        seeMoreBtn.text = "See less"
        seeMoreBtn.icon = UIImage(named: "ArrowUp")
        seeMoreBtn.sizeToFit()
    }
    
    func collapseDesc(){
        UIView.animate(withDuration: 0.4, animations: { [self] in
            detailSection.transform = CGAffineTransform(translationX: 0, y: 0)
            descBlanket.alpha = 1
        }) { completion in
            self.descLbl.numberOfLines = 3
            self.descLbl.snp.remakeConstraints { make in
                make.top.equalTo(self.nameLbl.snp.bottom).offset(12)
                make.width.equalToSuperview().offset(-40)
                make.centerX.equalToSuperview()
                make.height.equalTo(self.descTruncHeight)
            }
        }
        
        seeMoreBtn.text = "See more"
        seeMoreBtn.icon = UIImage(named: "ArrowDown")
        seeMoreBtn.sizeToFit()
    }
}
