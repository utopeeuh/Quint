//
//  UVPointView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 19/10/22.
//

import Foundation
import SnapKit
import UIKit

class UVPointView: UIView{
    private var number = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 20
        self.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        number.font = .interMedium(size: 22)
        
        addSubview(number)
        number.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(23)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setNumber(_ num: Int){
        number.text = String(num)
        if(num == 2 || num == 3){
            number.textColor = .black
            return
        }
        number.textColor = K.Color.whiteQuint
    }
}
