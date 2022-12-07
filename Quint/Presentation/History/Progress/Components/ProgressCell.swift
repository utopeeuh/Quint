//
//  ProgressCell.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/12/22.
//

import Foundation
import UIKit
import SnapKit

class ProgressCell: UICollectionViewCell{
    
    let width : CGFloat = (UIScreen.main.bounds.width-60)/3
    
    var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.font = .interMedium(size: 14)
        label.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        label.textColor = K.Color.greyQuint
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: width*159/110))
        
        multipleSubviews(view: imageView, dateLabel)
        
        imageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview().offset(-37)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.bottom.centerX.equalToSuperview()
            make.width.equalTo(0)
        }
    }
    
    public func setLog(log: LogModel){
        if (log.image != nil){
            imageView.image = UIImage(data: log.image!)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        dateLabel.text = dateFormatter.string(from: log.date)
        dateLabel.sizeToFit()
        dateLabel.snp.updateConstraints { make in
            make.width.equalTo(dateLabel.frame.width+20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
