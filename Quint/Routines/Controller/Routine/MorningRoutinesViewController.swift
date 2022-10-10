//
//  MorningRoutinesViewController.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 10/10/22.
//

import UIKit

@available(iOS 16.0, *)
class MorningRoutinesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        navBar()
        ConfigureUI()
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    func navBar() {
        let button = UIButton(type: .custom)
            //Set the image
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            //Set the title
        button.setTitle(" ", for: .normal)
        //Add target
        button.addTarget(self, action: #selector(goToHomeRoutine), for: .touchUpInside)
        button.tintColor = .white
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        button.sizeToFit()
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func goToHomeRoutine() {
        let controller = RoutineHomeViewController()
        navigationController?.popViewController(animated: true)
    }
    
    let navbar: UIView = {
        let nav = UIView()
        nav.backgroundColor = UIColor(red: 255/255, green: 161/255, blue: 92/255, alpha: 1)
        return nav
    }()
    
    private lazy var hStackViewHeader: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private let routineSteps: UILabel = {
        let label = UILabel()
        label.text = "Routine steps"
        label.font = label.font.withSize(22)
        label.textColor = .black
        return label
    }()
    
    private let editBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1), for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(13)
        button.setTitle("Edit steps", for: .normal)
        button.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        button.layer.cornerRadius = 14.0
        return button
    }()
    
    private let addBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1), for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(13)
        button.setTitle("+ Add new step", for: .normal)
        button.layer.cornerRadius = 8.0
        button.layer.borderWidth = 1.0
        return button
    }()
    
    private let finishBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(13)
        button.setTitle("Finish routine", for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .black
        return button
    }()
    
    override func configureComponents() {
        navbar.addSubview(sunIcon)
        navbar.addSubview(titleMorning)
        mainStackView.addArrangedSubview(navbar)
        
        hStackViewHeader.addArrangedSubview(routineSteps)
        hStackViewHeader.addArrangedSubview(editBtn)
        mainStackView.addArrangedSubview(hStackViewHeader)
        
        mainStackView.addArrangedSubview(addBtn)
        mainStackView.addArrangedSubview(finishBtn)
    }
    
    override func configureLayout() {
        view.addSubview(mainStackView)
        
        navbar.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.topLayoutGuide.snp.top)
            make.height.equalTo(252)
        }
        
        sunIcon.snp.makeConstraints { make in
            make.height.width.equalTo(64)
            make.centerX.equalTo(view.center.x)
            make.centerY.equalTo(126)
        }
        
        titleMorning.snp.makeConstraints { make in
            make.centerX.equalTo(view.center.x)
            make.top.equalTo(sunIcon.snp.bottom).offset(15)
        }
        
        routineSteps.snp.makeConstraints { make in
            make.top.equalTo(navbar.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        editBtn.snp.makeConstraints { make in
            make.width.equalTo(82)
            make.height.equalTo(28)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        addBtn.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        finishBtn.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    private let sunIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "wb_sunny")
        return image
    }()
    
    private let titleMorning: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.text = "Morning routine"
        title.font = title.font.withSize(30)
        return title
    }()
    
    func ConfigureUI() {
        
        configureComponents()
        configureLayout()
    }


}
