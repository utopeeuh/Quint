//
//  InsightResult.swift
//  Quint
//
//  Created by Vendly on 17/10/22.
//

import UIKit

class InsightResult: UIView {
    
    private let scrollView = UIScrollView()
    private let logPhoto = UIImageView()
    private let resultTypeView = ResultTypeView()
    private let resultProblemView = ResultProblemView()
//    private let collectionView = UICollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = K.Color.bgQuint
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        configureComponents()
        configureLayout()
    }
    
    func configureComponents() {
        
    }
    
    func configureLayout() {
        
        addSubview(resultTypeView)
        resultTypeView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(208)
        }
        
    }
    
}
