//
//  RoutineStepsTableViewCell.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 10/10/22.
//

import UIKit

class MorningRoutineStepsTableViewCell: UITableViewCell {
    
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
    
    var numLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.layer.cornerRadius = 14.0
        label.layer.backgroundColor = CGColor(red: 242/255, green: 105/255, blue: 6/255, alpha: 1)
        label.textAlignment = .center
        label.font = .interMedium(size: 16)
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.text = ""
        label.font = label.font.withSize(18)
        label.font = .interMedium(size: 18)
        return label
    }()
    
    var imageRight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
        image.isHidden = false
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
            make.left.equalTo(self.safeAreaInsets).offset(50)
            make.width.height.equalTo(28)
            make.top.equalTo(self.safeAreaInsets).offset(11)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(numLabel.snp.right).offset(20)
            make.top.equalTo(self.safeAreaInsets).offset(14.65)
        }
        
        imageRight.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right)
            make.top.equalTo(self.safeAreaInsets).offset(14.5)
            make.right.equalTo(self.safeAreaLayoutGuide).offset(-15)
        }
        
        hStackViewCell.snp.makeConstraints { make in
            make.width.equalTo(self.safeAreaLayoutGuide)
            make.left.equalTo(self.safeAreaInsets)
        }
    }
    
    func changeCons() {
        numLabel.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaInsets).offset(20)
            make.width.height.equalTo(28)
            make.top.equalTo(self.safeAreaInsets).offset(11)
        }
        
        imageRight.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right)
            make.top.equalTo(self.safeAreaInsets).offset(14.5)
            make.right.equalTo(self.safeAreaLayoutGuide).offset(-15)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: "MorningRoutineStepsTableViewCell")
        configureComponents()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        configureComponents()
        configureLayout()
    }
}
