//
//  DailySkincareTipsView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 10/10/22.
//

import Foundation
import SnapKit

class DailySkincareTips: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(patternImage: UIImage(named: "tipsBackground")!)
        self.layer.cornerRadius = 8.0
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }
    
    private lazy var vStackViewTips: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    private var headerTitle: UILabel = {
        let label = UILabel()
        label.text = "Daily skincare tips"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private var firstTips: UILabel = {
        let label = UILabel()
        label.text = "Hydration is a must for healthy, glowing skin. Dehydrated skin can feel dry, itchy, and dull."
        label.textColor = .white
        label.font = label.font.withSize(14)
        label.numberOfLines = 0
        return label
    }()
    
    private var secondTips: UILabel = {
        let label = UILabel()
        label.text = "Drink liquids throughout the day, including electrolytes, to keep your hydration level."
        label.textColor = .white
        label.font = label.font.withSize(14)
        label.numberOfLines = 0
        return label
    }()
    
    func setupView() {
        vStackViewTips.addArrangedSubview(headerTitle)
        vStackViewTips.addArrangedSubview(firstTips)
        vStackViewTips.addArrangedSubview(secondTips)
        addSubview(vStackViewTips)
    }
    
    func setupConstraints() {
        headerTitle.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaInsets).offset(20)
            make.right.equalTo(self.safeAreaInsets).offset(-20)
            make.top.equalTo(self.safeAreaInsets).offset(20)
        }
        
        firstTips.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaInsets).offset(20)
            make.right.equalTo(self.safeAreaInsets).offset(-20)
            make.top.equalTo(headerTitle.snp.bottom).offset(20)
            make.width.equalTo(300)
        }
        
        secondTips.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaInsets).offset(20)
            make.right.equalTo(self.safeAreaInsets).offset(-20)
            make.top.equalTo(firstTips.snp.bottom).offset(20)
            make.width.equalTo(300)
        }
    }
}
