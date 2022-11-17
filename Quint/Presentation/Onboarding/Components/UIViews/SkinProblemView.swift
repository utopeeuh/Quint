//
//  SkinProblemView.swift
//  Quint
//
//  Created by Vendly on 15/10/22.
//

import UIKit
import SnapKit
import TTGTags

@available(iOS 16.0, *)
class SkinProblemView: OnboardingParentView {
    
    private var selections = [String]()
    public let skinProblemLabel = UILabel()
    private let collectionView = TTGTextTagCollectionView()
    public let nextButton = NextButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        collectionView.delegate = self
        collectionView.reload()
        loadSelectedProblems(tagIndexes: [])
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureComponents() {
        
        collectionView.alignment = .left
        
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
        selectedContent.textColor = K.Color.greenQuint
        
        let selectedStyle = TTGTextTagStyle()
        selectedStyle.backgroundColor = K.Color.whiteQuint
        selectedStyle.cornerRadius = 8
        selectedStyle.textAlignment = .center
        selectedStyle.extraSpace = CGSize(width: 34, height: 20)
        selectedStyle.shadowOffset = CGSize(width: 0, height: 2)
        selectedStyle.shadowColor = K.Color.shadowQuint
        selectedStyle.shadowOpacity = 5.0
        selectedStyle.borderWidth = 1.5
        selectedStyle.borderColor = K.Color.greenQuint
        
        for i in 0..<K.Category.skinProblem.count {
            
            content.text = K.Category.skinProblem[i+1]!
            selectedContent.text = K.Category.skinProblem[i+1]!
            
            let textTag = TTGTextTag(content: content, style: style, selectedContent: selectedContent, selectedStyle: selectedStyle)
            collectionView.addTag(textTag)
            
        }

        nextButton.setText("Next")
        nextButton.addTarget(self, action: #selector(nextOnClick), for: .touchUpInside)
        
    }
    
    override func configureLayout() {
        
        multipleSubviews(view: skinProblemLabel,
                               collectionView,
                               nextButton)
        
        skinProblemLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(skinProblemLabel.snp.bottom).offset(32)
            make.width.equalToSuperview().offset(-40)
        }

        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalToSuperview().offset(-40)
        }
        
    }

    func getSelectedProblems() -> [Int]{
        var selectedIndexes: [Int] = []
        let firstTagId = collectionView.allTags().first?.tagId ?? 1
        collectionView.allSelectedTags().forEach { textTag in
            var newId = textTag.tagId - firstTagId
            selectedIndexes.append(Int(newId))
        }
        return selectedIndexes
    }

    func loadSelectedProblems(tagIndexes: [Int]){

        let problems = ProblemsRepository.shared.fetchProblemIsActive()

        //Load pre-selected tags
        collectionView.allTags().forEach { tag in
            let currentTagText = String(describing: tag.content.value(forKey: "text")!)
            problemLoop: for problem in problems {
                if problem.title ?? "" == currentTagText {
                    tag.selected = true
                }
            }
        }

    }

}

@available(iOS 16.0, *)
extension SkinProblemView: TTGTextTagCollectionViewDelegate {
    
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTap tag: TTGTextTag!, at index: UInt) {

        for i in 0..<K.Category.skinProblem.count {

            if textTagCollectionView.allTags().count == 0 {
                break
            }

            let tag = textTagCollectionView.getTagAt(UInt(i))
            
            if tag?.selected == true {
                nextButton.setEnabled()
                return
            }
            
        }

        nextButton.setDisabled()
        
    }
    
}
