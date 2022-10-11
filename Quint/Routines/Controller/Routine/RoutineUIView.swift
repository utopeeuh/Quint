//
//  RoutineUIView.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 10/10/22.
//

import Foundation
import SnapKit

@available(iOS 16.0, *)
class RoutineUIView: UIView {
    
    var btnId: Int!
    var isChecked: Bool!
    var currStack: UIStackView!
    var currPosition: Int!
    var name: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8.0
        self.isUserInteractionEnabled = true
        isChecked = false
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
        setupConstraints()
    }
    
    func setStackView(_ stack: UIStackView){
        self.currStack = stack
    }

    private lazy var hStackViewRoutine: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    var leftBtn: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(red: 202/255, green: 202/255, blue: 202/255, alpha: 1)
        return button
    }()
    
    @objc func pressed(){
        self.alpha = 0.6
        self.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        self.isUserInteractionEnabled = false
        leftBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        leftBtn.tintColor = UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1)
        if btnId == 1 {
            imageRoutine.image = UIImage(named: "iconMorningDisabled")
            titleRoutine.attributedText = NSAttributedString(
                string: "Morning routine",
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
        } else if btnId == 2 {
            imageRoutine.image = UIImage(named: "iconNightDisabled")
            titleRoutine.attributedText = NSAttributedString(
                string: "Night routine",
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
        }
        
        rearrangeStack()
        
        
    }
    
    //MARK: - Reposition
    func rearrangeStack(){
        if(currPosition == 3 && btnId == 3){
            return
        }
        moveDown()
        for item in self.currStack.arrangedSubviews{
            if let currRoutine = item as? RoutineUIView{
                
                if currRoutine.btnId == 3 {
                    currRoutine.logUnlock()
                }
                
                if currRoutine.btnId != self.btnId{
//                    if(self.isPosAndIdEqual() && currRoutine.isPosAndIdEqual()){
//                        return
//                    }
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
        self.leftBtn.setImage(UIImage(systemName: "lock.open"), for: .normal)
        self.isUserInteractionEnabled = true
    }
    
    func moveUp(){
        let moveY = CGFloat(65*(btnId-1))
        let multiplier = currPosition-1
        UIView.animate(withDuration: 0.2*Double(multiplier), animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -moveY)
        })
        
        self.currPosition = 1
    }
    
    func moveMid(){
        let moveY = CGFloat(65*(btnId-1)-65)
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -moveY)
        })
        
        self.currPosition = 2
    }
    
    func moveDown(){
        let moveY = CGFloat(65*(btnId-1)-130)
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

    
    var chevRight: UIImageView = {
        let image = UIImageView()
        image.tintColor = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
        return image
    }()
    
    var imageRoutine: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var titleRoutine: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.font = label.font.withSize(16)
        label.numberOfLines = 2
        return label
    }()
    
    func setupView() {
        hStackViewRoutine.addArrangedSubview(leftBtn)
        leftBtn.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        hStackViewRoutine.addArrangedSubview(imageRoutine)
        hStackViewRoutine.addArrangedSubview(titleRoutine)
        hStackViewRoutine.addArrangedSubview(chevRight)
        addSubview(hStackViewRoutine)
    }
    
    func setupConstraints() {
        leftBtn.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.top.equalTo(self.safeAreaInsets).offset(12.5)
        }
        
        imageRoutine.snp.makeConstraints { make in
            make.left.equalTo(leftBtn.snp.right).offset(10)
            make.top.equalTo(self.safeAreaInsets).offset(7.5)
        }
        
        titleRoutine.snp.makeConstraints { make in
            make.left.equalTo(imageRoutine.snp.right).offset(10)
            make.right.equalTo(chevRight.snp.left)
        }
        
        chevRight.snp.makeConstraints { make in
            make.left.equalTo(titleRoutine.snp.right).offset(125)
            make.right.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
    }
    
}
