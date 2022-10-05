//
//  CategoriesScrollableView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 05/10/22.
//

import Foundation
import UIKit
import SnapKit

class CategoriesScrollableView: UIView{
    
    var categories:[Int: String] = [:]
    var myScrollView:UIScrollView!
    var scrollWidth : CGFloat = 320
    let scrollHeight : CGFloat = 100
    let thumbNailWidth : CGFloat = 80
    let thumbNailHeight : CGFloat = 80
    let padding: CGFloat = 10
    
    override init(frame: CGRect){
        super.init(frame: frame)
     
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        self.backgroundColor = UIColor.yellow
        
        categories = [1: "image01",2: "image02", 3: "image01",4: "image02", 5: "image01",6: "image02"]

       scrollWidth = self.frame.width

       //setup scrollView
        myScrollView = UIScrollView(frame: CGRect(x: 0, y: self.frame.height - scrollHeight, width: scrollWidth, height: scrollHeight))

       //setup content size for scroll view
       let contentSizeWidth:CGFloat = (thumbNailWidth + padding) * (CGFloat(categories.count))
       let contentSize = CGSize(width: contentSizeWidth ,height: thumbNailHeight)

       myScrollView.contentSize = contentSize
        myScrollView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth


       for (index, value) in categories {
           var button:UIButton = UIButton(type: .custom) as! UIButton
           //calculate x for uibutton
           var xButton = CGFloat(padding * (CGFloat(index) + 1) + (CGFloat(index) * thumbNailWidth))
           button.frame = CGRect(x: xButton,y: padding, width: thumbNailWidth, height: thumbNailHeight)
           button.titleLabel?.text = value

           button.backgroundColor = UIColor.red
//           let image = UIImage(named:value)
//           button.setBackgroundImage(image, forState: .Normal)
//           button.addTarget(self, action: Selector("changeImage:"), forControlEvents: .TouchUpInside)

           myScrollView.addSubview(button)
       }

       self.addSubview(myScrollView)
    }
}

