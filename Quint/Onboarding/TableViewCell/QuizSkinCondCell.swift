//
//  QuizSkinCondCell.swift
//  Quint
//
//  Created by Vendly on 06/10/22.
//

import UIKit

class QuizSkinCondCell: UITableViewCell {
    
    static let id = "quizSkinCondCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addLeftBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var leftBorder: CALayer?

    let borderWidth: CGFloat = 2

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Add right border if we haven't already
        if leftBorder == nil {
            addLeftBorder()
        }
        
        // Update the frames based on the current bounds
        leftBorder?.frame = CGRect(x: 0,
                                   y: 0,
                                   width: borderWidth,
                                   height: bounds.maxY)
    }

    private func addLeftBorder() {
        leftBorder = CALayer()
        
        leftBorder?.backgroundColor = CGColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
        
        layer.addSublayer(leftBorder!)
    }
    
}

