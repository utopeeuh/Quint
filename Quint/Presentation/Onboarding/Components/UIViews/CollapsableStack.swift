//
//  CollapsableStack.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 20/10/22.
//

import Foundation
import UIKit
import SnapKit

class CollapsableStack: UIView{
    var selectedIndex: Int = 0
    var buttons: [CollapsableButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func append(_ button: CollapsableButton){
        addSubview(button)
        button.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
           
            if(buttons.isEmpty){
                make.top.equalToSuperview()
            }
            else{
                make.top.equalTo(buttons.last!.snp.bottom).offset(14)
            }
        }
        
        buttons.append(button)
    }
    
    func getHeight()->CGFloat{
        var totalHeight: CGFloat = 0
        buttons.forEach { b in
            totalHeight += b.getHiddenHeight()
        }
        return totalHeight + CGFloat(12*(buttons.count-1))
    }
    
    func showView(_ collapsable: CollapsableButton){
        selectedIndex = buttons.firstIndex(of: collapsable) ?? 0
        
        snp.updateConstraints { make in
            make.height.equalTo(getHeight()+collapsable.getHeightDiff())
        }
        
        for i in 0..<buttons.count{
            
            UIView.animate(withDuration: 0.4, animations: { [self] in
                buttons[i].transform = CGAffineTransform(translationX: 0, y: 0)
            })

            if(i != selectedIndex){
                buttons[i].hideDesc()
                
                if(i > selectedIndex && collapsable.descText.text != ""){
                    UIView.animate(withDuration: 0.4, animations: { [self] in
                        buttons[i].transform = CGAffineTransform(translationX: 0, y: collapsable.descText.requiredHeight+12)
                    })
                }
            }
        }
    }
}

@objc protocol CollapsableStackDelegate{
    @objc func onClickExpand(_ sender: CollapsableButton)
}


