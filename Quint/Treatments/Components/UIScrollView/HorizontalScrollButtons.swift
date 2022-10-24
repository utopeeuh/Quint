//
//  HorizontalScrollButtons.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/10/22.
//

import UIKit

class HorizontalScrollButtons: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = K.Color.bgQuint
        contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        setContentOffset(CGPoint(x: -20, y: 0), animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Pass the buttons to the scroll view
    // Make sure to be child of CategoryButton and have width & height
    // defined in the subclass (refer to SmallCategoryButton)
    func setButtons(_ buttons: [CategoryButton]){
        var totalWidth = 0

        for i in 0..<buttons.count {

            buttons[i].frame = CGRect(x: Int(CGFloat(totalWidth+K.Offset.sm*2*i)), y: 0, width: Int(buttons[i].frame.width), height: buttons[i].height)

            totalWidth = totalWidth + Int(buttons[i].frame.width)
            
            self.addSubview(buttons[i])
        }

        self.contentSize = CGSize( width: CGFloat(totalWidth+8*buttons.count), height: self.frame.size.height)
        self.showsHorizontalScrollIndicator = false
    }
}
