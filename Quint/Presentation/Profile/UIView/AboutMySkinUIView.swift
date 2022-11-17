//
//  AboutMySkinUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 02/11/22.
//

import UIKit
import TTGTags
import CoreData

class AboutMySkinUIView: UIView , TTGTextTagCollectionViewDelegate{
    
    var user: UserModel?
    var collectionView = TTGTextTagCollectionView.init(frame: CGRect(x: 0, y: 0, width: 270, height: 55))
    var idCollectionView: Int!
    var content = TTGTextTagStringContent()
    let style = TTGTextTagStyle()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, idCollectionView: Int) {
        super.init(frame: frame)
        
        user = UserRepository.shared.fetchUser()
        
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
       
        self.multipleSubviews(view: iconImage,
                                    namelabel)
        
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
        
        refreshData()
        
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

    func refreshData(){

        user = UserRepository.shared.fetchUser()

        if idCollectionView == 1 {
            getSkinType()
        } else if idCollectionView == 2 {

            getSkinProblem()

        } else if idCollectionView == 3 {

            getSensitiveSkin()

        } else {
            print("skipped")
        }
    }

    func getSkinType() {
        
        //fetch skin type
        let skinType = SkinTypesRepository.shared.fetchSkinType(id: Int(truncating: user!.skinTypeId))

        //remove inital tags
        collectionView.removeAllTags()

        //set text here
        content.text = skinType.title ?? "no data!"
        let textTag = TTGTextTag(content: content, style: style)
        collectionView.addTag(textTag)
        collectionView.reload()
        
    }
    
    func getSkinProblem() {

        //remove initial tags
        collectionView.removeAllTags()

        //fetch skin problem
        let skinProblemList = ProblemsRepository.shared.fetchProblemIsActive()
        
        //set text here
        for i in 0..<skinProblemList.count {
            content.text = skinProblemList[i].title ?? "no data!"
            let textTag = TTGTextTag(content: content, style: style)
            collectionView.addTag(textTag)
        }
        collectionView.reload()
        
    }
    
    func getSensitiveSkin() {

        //remove initial tags
        collectionView.removeAllTags()

        //fetch sensitive skin
        var sensitiveSkin = user?.isSensitive
        
        //set text here
        if sensitiveSkin == false {
            content.text = "No"
        } else {
            content.text = "Yes"
        }

        let textTag = TTGTextTag(content: content, style: style)
        collectionView.addTag(textTag)
        collectionView.reload()
        
    }
    
}
