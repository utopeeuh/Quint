//
//  AboutMySkinUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 02/11/22.
//

import UIKit
import TTGTags

class AboutMySkinUIView: UIView , TTGTextTagCollectionViewDelegate{
    
    var collectionView = TTGTextTagCollectionView.init(frame: CGRect(x: 0, y: 0, width: 270, height: 55))
    var idCollectionView: Int!
    var content = TTGTextTagStringContent()
    let style = TTGTextTagStyle()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8.0
        configureUI()
        collectionView.delegate = self
        collectionView.reload()
    }
    
    init(frame: CGRect, idCollectionView: Int) {
        super.init(frame: frame)
        self.idCollectionView = idCollectionView
        self.backgroundColor = .white
        self.layer.cornerRadius = 8.0
        configureUI()
        collectionView.delegate = self
        collectionView.reload()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var iconImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var namelabel: UILabel = {
        let label = UILabel()
        label.font = .interMedium(size: 16)
        label.textColor = .black
        return label
    }()
    
    var chevronImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = K.Color.greyQuint
        return imageView
    }()
    
    override func configureComponents() {
        self.addSubview(iconImage)
        self.addSubview(namelabel)
        
        collectionView.alignment = .left
        
        content.textFont = .interMedium(size: 12)!
        content.textColor = K.Color.blackQuint
        
        style.backgroundColor = K.Color.disableBgBtnQuint
        style.cornerRadius = 8
        style.textAlignment = .center
        style.extraSpace = CGSize(width: 20, height: 4)
        style.shadowOffset = CGSize(width: 0, height: 2)
        style.shadowColor = K.Color.shadowQuint
        style.shadowOpacity = 5.0
        
        if idCollectionView == 1 {
            content.text = "Normal"
            let textTag = TTGTextTag(content: content, style: style)
            collectionView.addTag(textTag)
        }else if idCollectionView == 2 {
            for i in 0..<K.Category.skinProblem.count {
                
                content.text = K.Category.skinProblem[i+1]!
                
                let textTag = TTGTextTag(content: content, style: style)
                collectionView.addTag(textTag)
            }
        }else if idCollectionView == 3 {
            content.text = "No"
            let textTag = TTGTextTag(content: content, style: style)
            collectionView.addTag(textTag)
        }
        
        self.addSubview(collectionView)
        
        self.addSubview(chevronImage)
    }
    
    override func configureLayout() {
        
        iconImage.snp.makeConstraints { make in
            make.left.top.equalTo(self.safeAreaInsets).offset(9)
            make.width.height.equalTo(32)
        }
        
        namelabel.snp.makeConstraints { make in
            make.left.equalTo(iconImage.snp.right).offset(15)
            make.top.equalTo(self.safeAreaInsets).offset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.top.equalTo(namelabel.snp.bottom).offset(2)
            make.left.equalTo(iconImage.snp.right).offset(15)
        }
        
        chevronImage.snp.makeConstraints { make in
            make.right.equalTo(self.safeAreaInsets).offset(-9)
            if idCollectionView == 1 || idCollectionView == 3 {
                make.top.equalTo(24)
            }else if idCollectionView == 2 {
                make.top.equalTo(33)
            }
            
        }
    }

}
