//
//  moodSliderUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 13/10/22.
//

import UIKit
import SnapKit

class MoodSliderUIView: UIView {
    
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
        return mySlider
    }()
    
    var moodDetail: UILabel = {
        let label = UILabel()
        label.text = "Nothing special"
        label.textColor = .black
        label.font = .interMedium(size: 18)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8.0
        self.isUserInteractionEnabled = true
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func configureComponents() {
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        vStackViewSlider.addArrangedSubview(moodSlider)
        vStackViewSlider.addArrangedSubview(moodDetail)
    }
    
    
    override func configureLayout() {
        self.addSubview(vStackViewSlider)
        
        UIView.animate(withDuration: 0.8) { [self] in
            moodSlider.setValue(40.0, animated: true)
        }
        
        vStackViewSlider.snp.makeConstraints { make in
            make.height.equalToSuperview().offset(-40)
            make.center.equalToSuperview()
        }
        
        moodSlider.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width-88)
            make.height.equalTo(42)
        }
        
        moodDetail.snp.makeConstraints { make in
            make.top.equalTo(moodSlider.snp.bottom).offset(20)
        }
    }


}
