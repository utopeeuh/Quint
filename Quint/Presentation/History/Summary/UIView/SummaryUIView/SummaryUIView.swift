//
//  SummaryUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 24/10/22.
//

import UIKit

class SummaryUIView: UIView {
    
    var logList: [LogModel]!{
        didSet {
            setData()
        }
    }
    
    var descriptionText: String!
    var imageName: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10.0
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    
    var titleImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .interSemiBold(size: 16)
        label.textColor = .black
        return label
    }()
    
    var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .interMedium(size: 14)
        label.textColor = K.Color.greyQuint
        return label
    }()
    
    var bigNumLabel: UILabel = {
        let label = UILabel()
        label.font = .clashGroteskMedium(size: 30)
        label.textColor = .black
        return label
    }()
    
    var bigTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .clashGroteskMedium(size: 30)
        label.textColor = .black
        return label
    }()
    
    var bigTitleImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var descLabel: UILabel = {
        let label = UILabel()
        label.font = .interMedium(size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    func setData() {
        
    }
    
    override func configureComponents() {
        self.addSubview(titleImage)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        hStackView.addArrangedSubview(bigNumLabel)
        hStackView.addArrangedSubview(bigTitleLabel)
        hStackView.addArrangedSubview(bigTitleImage)
        self.addSubview(hStackView)
        self.addSubview(descLabel)
    }
    
    override func configureLayout() {
        titleImage.snp.makeConstraints { make in
            make.height.width.equalTo(36)
            make.top.left.equalTo(self.safeAreaInsets).offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleImage.snp.right).offset(15)
            make.top.equalTo(self.safeAreaInsets).offset(27.5)
        }
        
        bigTitleImage.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(self.safeAreaInsets).offset(20)
        }
        
        hStackView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(10)
            make.left.equalTo(self.safeAreaInsets).offset(20)
        }
        
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaInsets).offset(20)
            make.right.equalTo(self.safeAreaInsets).offset(-20)
            make.top.equalTo(hStackView.snp.bottom).offset(10)
        }
    }
    
}
