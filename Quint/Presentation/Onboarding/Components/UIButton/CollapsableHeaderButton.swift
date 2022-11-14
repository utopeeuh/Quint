//
//  CollapsableHeaderButton.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 20/10/22.
//

import Foundation
import UIKit
import SnapKit
import Charts

class CollapsableHeaderButton: UIButton{
    
    private var btnFrame = UIView()
    private var numberFrame = UIView()
    private var numberLbl = UILabel()
    private var title = UILabel()
    private var chevron = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        contentHorizontalAlignment = .left
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        layer.borderColor = K.Color.greenQuint.cgColor
        layer.cornerRadius = 8
        backgroundColor = K.Color.whiteQuint
        sizeToFit()
        
        titleLabel!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-72, height: 0)
        titleLabel!.font = .interMedium(size: 16)
        titleLabel!.lineBreakMode = .byWordWrapping
        titleLabel!.numberOfLines = 0
        setTitleColor(.black, for: .normal)
        
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: titleLabel!.requiredHeight+28)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0
        layer.shadowOffset = CGSize(width: 0, height: titleLabel!.requiredHeight+28)
        layer.shadowRadius = 16
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setNumber(_ i: Int){
        addSubview(btnFrame)
        btnFrame.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        btnFrame.backgroundColor = .clear
        btnFrame.isUserInteractionEnabled = false
        btnFrame.layer.cornerRadius = self.layer.cornerRadius
        
        titleLabel!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-140, height: 0)
        titleLabel?.sizeToFit()
        
        numberFrame.backgroundColor = K.Color.bgQuint
        numberFrame.layer.cornerRadius = 12
        
        numberLbl.text = String(i)
        numberLbl.font = .interMedium(size: 14)
        numberLbl.textAlignment = .center
        
        chevron = UIImageView(image: UIImage(named: "ChevronDown"))
        
        if let superCollapsable = superview as? CollapsableButton{
            
            if superCollapsable.descText.text == "" {
                chevron.alpha = 0
                
            }
        }
        
        btnFrame.addSubview(numberFrame)
        btnFrame.addSubview(numberLbl)
        btnFrame.addSubview(chevron)
        
        numberFrame.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(12)
            make.size.equalTo(24)
        }
        
        numberLbl.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.center.equalTo(numberFrame)
        }
        
        chevron.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(numberFrame)
        }
        
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
    }
    
    func selected(){
        layer.borderWidth = 1.5
        titleLabel!.font = .interSemiBold(size: 16)
        setTitleColor(K.Color.greenQuint, for: .normal)
        numberFrame.applyGradient(colours: [K.Color.greenLightQuint, K.Color.greenQuint], locations: [0,1], radius: 12)
        numberLbl.textColor = K.Color.whiteQuint
        chevron.image = UIImage(named: "ChevronUp")
        layer.shadowOpacity = 0.08
    }
    
    func deselect(){
        for i in 0..<(numberFrame.layer.sublayers?.count ?? 0){
            numberFrame.layer.sublayers!.remove(at: 0)
        }
                
        titleLabel!.font = .interMedium(size: 16)
        numberLbl.textColor = K.Color.blackQuint
        chevron.image = UIImage(named: "ChevronDown")
        layer.borderWidth = 0
        titleLabel?.textColor = .black
        layer.shadowOpacity = 0
    }
}
