//
//  moodSliderUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 13/10/22.
//

import UIKit

class moodSliderUIView: UIView {
    
    private lazy var vStackViewSlider: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    var moodSlider: UISlider = {
        let mySlider = UISlider()
        mySlider.minimumValue = 0
        mySlider.maximumValue = 80
        mySlider.isContinuous = true
        mySlider.tintColor = K.Color.greenQuint
        mySlider.setThumbImage(UIImage(named: "neutralEmoji"), for: .normal)
        mySlider.backgroundColor = .white
        return mySlider
    }()
    
    var moodDetail: UILabel = {
        let label = UILabel()
        label.text = "Nothing special"
        label.textColor = .black
        label.font = label.font.withSize(18)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8.0
        self.isUserInteractionEnabled = true
        configureComponents()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureComponents()
        configureLayout()
        
    }
    
    func configureComponents() {
        vStackViewSlider.addArrangedSubview(moodSlider)
        vStackViewSlider.addArrangedSubview(moodDetail)
    }
    
    
    func configureLayout() {
        self.addSubview(vStackViewSlider)
        
        UIView.animate(withDuration: 0.8) { [self] in
            moodSlider.setValue(40.0, animated: true)
        }
        
        moodSlider.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(30)
            make.left.equalTo(self.safeAreaInsets).offset(25)
            make.right.equalTo(self.safeAreaInsets).offset(-25)
            make.top.equalTo(self.safeAreaInsets).offset(20)
        }
        
        moodDetail.snp.makeConstraints { make in
            make.top.equalTo(moodSlider.snp.bottom).offset(15)
        }
    }


}
