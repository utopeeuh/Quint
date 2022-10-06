//
//  QuizSkinTypeCell.swift
//  Quint
//
//  Created by Vendly on 06/10/22.
//

import UIKit

class QuizSkinTypeCell: UITableViewCell {
    
    static let id = "customTableViewCell"
    
    private let cellView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        return view
        
    }()
    
    private let skinTypeLbl: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 1
        return label
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(skinTypeLbl)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
