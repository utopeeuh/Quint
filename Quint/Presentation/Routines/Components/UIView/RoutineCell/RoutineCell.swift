//
//  RoutineUIView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 10/10/22.
//

import Foundation
import SnapKit

@available(iOS 16.0, *)

@objc protocol RoutineCellDelegate{
    @objc func pressed()
}

class RoutineCell: UIView, RoutineCellDelegate{
    
    var btnId: Int!
    var isChecked: Bool!
    var currStack: UIStackView!
    var currPosition: Int!
    var name: String!
    
    var delegate : RoutineReminderDelegate?
    
    var leftBtn: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(red: 202/255, green: 202/255, blue: 202/255, alpha: 1)
        return button
    }()
    
    var chevRight: UIImageView = {
        let image = UIImageView()
        image.tintColor = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
        image.image = UIImage(named: "ChevronRight")
        return image
    }()
    
    var imageRoutine: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var titleRoutine: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.font = .interMedium(size: 16)
        label.numberOfLines = 2
        return label
    }()
    
    required init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8.0
        self.isUserInteractionEnabled = true
        frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 60)
        leftBtn.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        isChecked = false
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func configureLayout() {
        
        multipleSubviews(view: leftBtn, imageRoutine, titleRoutine, chevRight)
        
        subviews.forEach { view in
            view.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
            }
        }
        
        leftBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        imageRoutine.snp.makeConstraints { make in
            make.left.equalTo(leftBtn.snp.right).offset(10)
        }
        
        titleRoutine.snp.makeConstraints { make in
            make.left.equalTo(imageRoutine.snp.right).offset(10)
        }
        
        chevRight.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-22.3)
        }
    }
    
    func setStackView(_ stack: UIStackView){
        self.currStack = stack
    }
    
    func pressed(){}
    
    //MARK: - Reposition
    func rearrangeStack(){
        if(currPosition == 3 && btnId == 3){
            return
        }
        moveDown()
        for item in self.currStack.arrangedSubviews{
            if let currRoutine = item as? RoutineCell{
                
                if currRoutine.btnId == 3 {
                    currRoutine.logUnlock()
                }
                
                if currRoutine.btnId != self.btnId{
                    switch currRoutine.currPosition {
                    case 2:
                        currRoutine.moveUp()
                        break
                    case 3:
                        currRoutine.moveMid()
                        break
                    default: break
                    }
                }
            }
            
            if let reminderView = item as? ReminderUIView{
                reminderView.isHidden = true
            }
            
        }
    }
    
    func logUnlock() {
        if leftBtn.image(for: .normal) != UIImage(named: "CheckmarkFill"){
            self.leftBtn.setImage(UIImage(named: "LockOpen"), for: .normal)
            self.isUserInteractionEnabled = true
        }
    }
    
    func moveUp(){
        let moveY = CGFloat(72*(btnId-1))
        let multiplier = currPosition-1
        UIView.animate(withDuration: 0.2*Double(multiplier), animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -moveY)
        })
        
        self.currPosition = 1
    }
    
    func moveMid(){
        let moveY = CGFloat(72*(btnId-1)-72)
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -moveY)
        })
        
        self.currPosition = 2
    }
    
    func moveDown(){
        let moveY = CGFloat(72*(btnId-1)-144)
        print(moveY)
        let multiplier = 3-currPosition
        UIView.animate(withDuration: 0.2*Double(multiplier), animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -moveY)
        })
        
        self.currPosition = 3
    }
    
    func isPosAndIdEqual() -> Bool{
        if(currPosition == btnId){
            return true
        }
        
        return false
    }
    
}
