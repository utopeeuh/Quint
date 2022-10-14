//
//  QuizNavigationBar.swift
//  Quint
//
//  Created by Vendly on 13/10/22.
//

import UIKit
import SwiftUI
import SnapKit

class QuizNavigationBar: UIView {
    
    public let progressBar = UIProgressView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .systemGreen
        
        progressBar.trackTintColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        progressBar.progressTintColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
        progressBar.setProgress(0.16, animated: true)
        progressBar.layer.cornerRadius = 4
        progressBar.clipsToBounds = true

    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        
        addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(7)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
}

struct QuizNavBarPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            QuizNavigationBar()
        }
        .frame(maxWidth: .infinity, maxHeight: 44, alignment: .top)
        .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
        .previewDisplayName("iPhone 14")
        
        ViewPreview {
            QuizNavigationBar()
        }
        .frame(maxWidth: .infinity, maxHeight: 44, alignment: .top)
        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        .previewDisplayName("iPhone 8")
    }
}
