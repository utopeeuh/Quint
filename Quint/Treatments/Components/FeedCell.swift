//
//  FeedCell.swift
//  DynamicCell
//
//  Created by Mohannad on 29.03.2021.
//


import UIKit
import Kingfisher

class FeedCell: UICollectionViewCell {
    
    var img : UIImageView = {
      let img = UIImageView()
      img.backgroundColor = .gray
      img.contentMode = .scaleAspectFill
      img.clipsToBounds = true
      img.translatesAutoresizingMaskIntoConstraints = false
      img.setContentHuggingPriority(.defaultLow, for: .vertical)
      return img
    }()
    
    var descLab : UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.numberOfLines = 0
        lab.lineBreakMode = .byWordWrapping
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.font = UIFont(name: "Helvetica", size: 16)
        lab.setContentHuggingPriority(.defaultHigh, for: .vertical)
       return lab
    }()
    
    var info : Photo? {
        didSet {
            assignPhoto()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureComponents()
        configureLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        info = nil
        img.removeFromSuperview()
        descLab.removeFromSuperview()

    }
    
    deinit {
        info = nil
    }
    
    
    func configureComponents(){
        layer.borderWidth = 1
        layer.borderColor =  UIColor.lightGray.cgColor
        backgroundColor = .red
        contentView.addSubview(img)
        contentView.addSubview(descLab)
    
    }
    
    func configureLayout(){
        img.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.width.equalTo(contentView)
        }
      
        descLab.snp.makeConstraints { make in
            make.top.equalTo(img.snp.bottom)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
            make.width.equalTo(contentView).offset(-10)
            make.centerX.equalTo(contentView)
        }
    }
    
    func assignPhoto(){
        
        guard let data = info else {
            return
        }
        
        img.kf.setImage(with: URL(string: data.download_url)!) { res in
            if case .success(let value)  = res   {
                ImageCache.default.store(value.image, forKey: data.download_url)
            }
        }
    }
    
}

