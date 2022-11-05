//
//  HeaderProfileUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 31/10/22.
//

import UIKit

class HeaderProfileUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = K.Color.bgQuint
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var namelabel: UILabel = {
        let label = UILabel()
        label.font = .clashGroteskMedium(size: 25)
        label.text = "Profile"
        label.textColor = .black
        return label
    }()
    
    override func configureComponents() {
        self.addSubview(namelabel)
    }
    
    override func configureLayout() {
        namelabel.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaInsets)
        }
        
    }

}
