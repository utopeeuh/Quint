//
//  RoutineDetailStepCell.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 10/10/22.
//

import UIKit

class RoutineDetailStepCell: UITableViewCell {
    
    private var isEditingTable = false
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.autoresizesSubviews = false
        return view
    }()
    
    let spacerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var numLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.layer.cornerRadius = 14.0
        label.textAlignment = .center
        label.font = .interMedium(size: 16)
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.text = ""
        label.font = label.font.withSize(18)
        label.font = .interMedium(size: 18)
        return label
    }()
    
    var imageRight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
        image.isHidden = false
        return image
    }()
    
    var trashBtn = RoutineCellTrashButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        superview?.subviews.filter({ "\(type(of: $0))" == "UIShadowView" }).forEach { (sv: UIView) in
            sv.removeFromSuperview()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: "RoutineDetailStepCell")
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellInfo(title: String, position: Int){
        numLabel.text = String(describing: position)
        titleLabel.text = title
        trashBtn.cellTitle = title
    }
    
    override func configureComponents() {
        backgroundColor = .clear
        layer.borderWidth = 0
        isUserInteractionEnabled = true
        
        containerView.multipleSubviews(view: numLabel, titleLabel, imageRight)
        containerView.autoresizesSubviews = false
        
    }
    
    override func configureLayout() {
        addSubview(trashBtn)
        addSubview(containerView)
        addSubview(spacerView)
        
        trashBtn.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.left.equalToSuperview()
        }
        
        numLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(28)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(numLabel.snp.right).offset(20)
            make.centerY.equalToSuperview()
        }
        
        imageRight.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-18)
        }
        
        spacerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(containerView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.left.right.equalToSuperview()
        }
    }
    
    func setMorningCell(){
        numLabel.layer.backgroundColor = CGColor(red: 242/255, green: 105/255, blue: 6/255, alpha: 1)
    }
    
    func setNightCell(){
        numLabel.layer.backgroundColor = UIColor(red: 45/255, green: 61/255, blue: 119/255, alpha: 1).cgColor
    }
    
    func setEditingOff(){
        imageRight.image = UIImage(systemName: "chevron.right")
        imageRight.transform = CGAffineTransform(translationX: -40, y: 0)
        self.bringSubviewToFront(containerView)
        UIView.animate(withDuration: 0.4) { [self] in
            imageRight.transform = CGAffineTransform(translationX: 0, y: 0)
            containerView.transform = CGAffineTransform(translationX: 0, y: 0)
            trashBtn.alpha = 0
            trashBtn.isEnabled = false
        }
        containerView.snp.updateConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        containerView.layoutIfNeeded()
        isEditingTable = false
    }
    
    func setEditingOn(){
        imageRight.image = UIImage(named: "GridDots")
        UIView.animate(withDuration: 0.4, animations: { [self] in
            imageRight.transform = CGAffineTransform(translationX: -40, y: 0)
            containerView.transform = CGAffineTransform(translationX: 40, y: 0)
            trashBtn.alpha = 1
            trashBtn.isEnabled = true
        }) { completion in
            self.imageRight.transform = CGAffineTransform(translationX: 0, y: 0)
            self.containerView.snp.updateConstraints { make in
                make.right.equalToSuperview().offset(-40)
            }
            self.bringSubviewToFront(self.trashBtn)
            
            self.isEditingTable = true
        }
        
    }
}


