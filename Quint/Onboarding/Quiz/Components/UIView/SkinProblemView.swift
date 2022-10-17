//
//  SkinProblemView.swift
//  Quint
//
//  Created by Vendly on 15/10/22.
//

import UIKit
import TTGTags

class SkinProblemView: UIView {
    
    private var selections = [String]()
    private let skinProblemLabel = UILabel()
    private let collectionView = TTGTextTagCollectionView()
    public let nextButton = NextButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
        
        collectionView.alignment = .left
        collectionView.delegate = self
        collectionView.reload()
        
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        configureComponents()
        configureLayout()
    }
    
    func configureComponents() {
        
        skinProblemLabel.numberOfLines = 2
        skinProblemLabel.textColor = K.Color.blackQuint
        skinProblemLabel.text = "What is your skin\nproblems?"
        skinProblemLabel.font = .clashGroteskMedium(size: 30)
        skinProblemLabel.textAlignment = .left
        
        let content = TTGTextTagStringContent()
        content.textFont = .interRegular(size: 16)!
        content.textColor = K.Color.blackQuint
        
        let style = TTGTextTagStyle()
        style.backgroundColor = K.Color.whiteQuint
        style.cornerRadius = 8
        style.textAlignment = .center
        style.extraSpace = CGSize(width: 34, height: 20)
        style.shadowOffset = CGSize(width: 0, height: 2)
        style.shadowColor = K.Color.shadowQuint
        style.shadowOpacity = 5.0
        
        let selectedContent = TTGTextTagStringContent()
        selectedContent.textFont = .interSemiBold(size: 16)!
        selectedContent.textColor = K.Color.greenButtonQuint
        
        let selectedStyle = TTGTextTagStyle()
        selectedStyle.backgroundColor = K.Color.whiteQuint
        selectedStyle.cornerRadius = 8
        selectedStyle.textAlignment = .center
        selectedStyle.extraSpace = CGSize(width: 34, height: 20)
        selectedStyle.shadowOffset = CGSize(width: 0, height: 2)
        selectedStyle.shadowColor = K.Color.shadowQuint
        selectedStyle.shadowOpacity = 5.0
        selectedStyle.borderWidth = 1.5
        selectedStyle.borderColor = K.Color.greenButtonQuint
        
        for i in 0..<K.Category.skinProblem.count {
            
            content.text = K.Category.skinProblem[i+1]!
            selectedContent.text = K.Category.skinProblem[i+1]!
            
            let textTag = TTGTextTag(content: content, style: style, selectedContent: selectedContent, selectedStyle: selectedStyle)
            collectionView.addTag(textTag)
            
        }
        
        nextButton.setText("Next")
        
    }
    
    func configureLayout() {
        
        addSubview(skinProblemLabel)
        addSubview(collectionView)
        addSubview(nextButton)
        
        skinProblemLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
            make.width.equalToSuperview().offset(-40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(skinProblemLabel.snp.bottom).offset(32)
            make.width.equalTo(350)
            make.height.equalTo(156)
        }

        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-62)
            make.width.equalToSuperview().offset(-40)
        }

        
    }
    
}

extension SkinProblemView: TTGTextTagCollectionViewDelegate {
    
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTap tag: TTGTextTag!, at index: UInt) {
        
        for i in 0..<K.Category.skinProblem.count {

            let currTag = textTagCollectionView.getTagAt(UInt(i))
            
            if currTag?.selected  == true {
                nextButton.backgroundColor = K.Color.greenButtonQuint
                nextButton.setTitleColor(K.Color.whiteQuint, for: .normal)
                nextButton.isEnabled = true
                return
            } else {
                nextButton.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
                nextButton.setTitleColor(UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1), for: .normal)
                nextButton.isEnabled = false
                return
            }

        }
        
        nextButton.isEnabled = false
        
    }
    
}
