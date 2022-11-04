//
//  DailySkincareTipsView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 10/10/22.
//

import Foundation
import SnapKit

class DailySkincareTips: UIView {
    
    var height : CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(patternImage: UIImage(named: "tipsBackground")!)
        self.layer.cornerRadius = 8.0
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
        label.font = .clashGroteskMedium(size: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private var firstTips: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-88, height: 0)
        label.lineBreakMode = .byWordWrapping
        label.font = .interRegular(size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    override func configureComponents() {
        
        firstTips.text = DataHelper.shared.fetchRandomTip()
        firstTips.sizeToFit()
        height = firstTips.requiredHeight + 98
    }
    
    override func configureLayout() {
        
        addSubview(headerTitle)
        addSubview(firstTips)
        
        headerTitle.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaInsets).offset(24)
            make.right.equalTo(self.safeAreaInsets).offset(-24)
            make.top.equalTo(self.safeAreaInsets).offset(28)
        }
        
        firstTips.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaInsets).offset(24)
            make.right.equalTo(self.safeAreaInsets).offset(-24)
            make.top.equalTo(headerTitle.snp.bottom).offset(10)
            make.height.equalTo(firstTips.requiredHeight)
        }
    }
}
