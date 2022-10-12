//
//  SourceCell.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 12/10/22.
//

import Foundation
import UIKit
import SnapKit

class SourceCell: UIView{
    
    
    private var linkLabel = UILabel()
    
    required init(_ url: String) {
        super.init(frame: .zero)
        backgroundColor = K.Color.whiteQuint
        layer.cornerRadius = 8
        
        linkLabel.textColor = K.Color.greenQuint
        linkLabel.font = .interRegular(size: 16)
        linkLabel.isUserInteractionEnabled = true
        linkLabel.numberOfLines = 0
        linkLabel.lineBreakMode = .byWordWrapping
        linkLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-68, height: 0)
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: url, attributes: underlineAttribute)
        linkLabel.attributedText = underlineAttributedString
        linkLabel.sizeToFit()
        
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.linkLabelTapped(_:)))
        self.linkLabel.isUserInteractionEnabled = true
        self.linkLabel.addGestureRecognizer(labelTap)
        
        addSubview(linkLabel)
        
        linkLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.height.equalToSuperview().offset(-28)
            make.center.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.height.equalTo(linkLabel.frame.height + 32)
        }
    }

    @objc func linkLabelTapped(_ sender: UITapGestureRecognizer) {
        guard let url = URL(string: linkLabel.text!) else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
