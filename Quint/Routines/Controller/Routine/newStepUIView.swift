//
//  newStepUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 17/10/22.
//

import UIKit

class newStepUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.cornerRadius = 8.0
        self.isUserInteractionEnabled = true
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
        setupConstraints()
    }
    
    private lazy var hStackViewNewStep: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 230
        return stackView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = label.font.withSize(16)
        return label
    }()
    
    var imagePlus: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "plus")
        image.tintColor = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
        return image
    }()
    
    func setupView() {
        hStackViewNewStep.addArrangedSubview(titleLabel)
        hStackViewNewStep.addArrangedSubview(imagePlus)
        addSubview(hStackViewNewStep)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaLayoutGuide)
        }
        
        imagePlus.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right)
            make.right.equalTo(self.safeAreaLayoutGuide)
            make.height.width.equalTo(20)
        }
    }
    
    
}
