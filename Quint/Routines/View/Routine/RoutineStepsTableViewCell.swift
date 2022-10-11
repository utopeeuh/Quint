//
//  RoutineStepsTableViewCell.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 10/10/22.
//

import UIKit

class RoutineStepsTableViewCell: UITableViewCell {
    
    var product: Product? {
        didSet {
            numLabel.text = product?.numLabel
            titleLabel.text = product?.titleLabel
            imageRight.image = product?.imageRight
        }
    }
    
    private lazy var hStackViewCell: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private var numLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.layer.cornerRadius = 14.0
        label.layer.backgroundColor = CGColor(red: 255/255, green: 161/255, blue: 92/255, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.text = ""
        label.font = label.font.withSize(18)
        return label
    }()
    
    private var imageRight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
        return image
    }()
    
    func configureComponents() {
        hStackViewCell.addArrangedSubview(numLabel)
        hStackViewCell.addArrangedSubview(titleLabel)
        hStackViewCell.addArrangedSubview(imageRight)
    }
    
    func configureLayout() {
        self.addSubview(hStackViewCell)
        numLabel.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaInsets).offset(20)
            make.width.height.equalTo(28)
            make.top.equalTo(self.safeAreaInsets).offset(7.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(numLabel.snp.right).offset(20)
            make.top.equalTo(self.safeAreaInsets).offset(10.8)
        }
        
        imageRight.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right)
            make.top.equalTo(self.safeAreaInsets).offset(11.5)
            make.right.equalTo(self.safeAreaLayoutGuide).offset(-15)
        }
        
        hStackViewCell.snp.makeConstraints { make in
            make.width.equalTo(self.safeAreaLayoutGuide)
            make.left.equalTo(self.safeAreaInsets)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: "RoutineStepsTableViewCell")
        configureComponents()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        configureComponents()
        configureLayout()
    }
}
