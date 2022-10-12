//
//  DailyLogViewController.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 11/10/22.
//

import UIKit

@available(iOS 16.0, *)
class DailyLogViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        self.title = "Daily skin log"
        navBar()
        ConfigureUI()
    }
    
    func ConfigureUI() {
        configureComponents()
        configureLayout()
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    private var moodLabel: UILabel = {
        let label = UILabel()
        label.text = "How do you feel today?"
        label.font = label.font.withSize(20)
        label.textColor = .black
        return label
    }()
    
    private var sleepLabel: UILabel = {
        let label = UILabel()
        label.text = "How long did you sleep last night?"
        label.font = label.font.withSize(20)
        label.textColor = .black
        return label
    }()
    
    private var activityLabel: UILabel = {
        let label = UILabel()
        label.text = "What is your today's activity level?"
        label.font = label.font.withSize(20)
        label.textColor = .black
        return label
    }()
    
    private var feelSkinLabel: UILabel = {
        let label = UILabel()
        label.text = "How do you feel about your skin?"
        label.font = label.font.withSize(20)
        label.textColor = .black
        return label
    }()
    
    private let createLogBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(13)
        button.setTitle("Create log", for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = K.Color.greenQuint
        return button
    }()
    
    private lazy var hStackButtonFeelSkin: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let feelBetterBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(K.Color.greenQuint, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(13)
        button.setImage(UIImage(systemName: "hand.thumbsup.fill")?.withTintColor(K.Color.greenQuint, renderingMode: .alwaysOriginal), for: .normal)
        button.setTitle(" Better", for: .normal)
        button.layer.cornerRadius = 8.0
        button.layer.borderColor = CGColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        button.layer.borderWidth = 1.0
        return button
    }()
    
    private let feelWorseBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(K.Color.greenQuint, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(13)
        button.setImage(UIImage(systemName: "hand.thumbsdown.fill")?.withTintColor(K.Color.greenQuint, renderingMode: .alwaysOriginal), for: .normal)
        button.setTitle(" Worsen", for: .normal)
        button.layer.cornerRadius = 8.0
        button.layer.borderColor = CGColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        button.layer.borderWidth = 1.0
        return button
    }()
    
    @objc func feelBetterHandler() {
        feelBetterBtn.layer.backgroundColor = CGColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        feelBetterBtn.setTitleColor(.white, for: .normal)
        feelBetterBtn.setImage(UIImage(systemName: "hand.thumbsup.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        
        feelWorseBtn.setTitleColor(K.Color.greenQuint, for: .normal)
        feelWorseBtn.setImage(UIImage(systemName: "hand.thumbsdown.fill")?.withTintColor(K.Color.greenQuint, renderingMode: .alwaysOriginal), for: .normal)
        feelWorseBtn.layer.backgroundColor = CGColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
    }
    
    @objc func feelWorseHandler() {
        feelWorseBtn.layer.backgroundColor = CGColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        feelWorseBtn.setTitleColor(.white, for: .normal)
        feelWorseBtn.setImage(UIImage(systemName: "hand.thumbsdown.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        
        feelBetterBtn.setTitleColor(K.Color.greenQuint, for: .normal)
        feelBetterBtn.setImage(UIImage(systemName: "hand.thumbsup.fill")?.withTintColor(K.Color.greenQuint, renderingMode: .alwaysOriginal), for: .normal)
        feelBetterBtn.layer.backgroundColor = CGColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
    }
    
    override func configureComponents() {
        mainStackView.addArrangedSubview(moodLabel)
        mainStackView.addArrangedSubview(sleepLabel)
        mainStackView.addArrangedSubview(activityLabel)
        mainStackView.addArrangedSubview(feelSkinLabel)
        
        hStackButtonFeelSkin.addArrangedSubview(feelBetterBtn)
        feelBetterBtn.addTarget(self, action: #selector(feelBetterHandler), for: UIControl.Event.touchUpInside)
        hStackButtonFeelSkin.addArrangedSubview(feelWorseBtn)
        feelWorseBtn.addTarget(self, action: #selector(feelWorseHandler), for: UIControl.Event.touchUpInside)
        mainStackView.addArrangedSubview(hStackButtonFeelSkin)
        
        
        mainStackView.addArrangedSubview(createLogBtn)
    }
    
    override func configureLayout() {
        view.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        moodLabel.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaInsets).offset(20)
        }
        
        sleepLabel.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaInsets).offset(20)
        }
        
        activityLabel.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaInsets).offset(20)
        }
        
        feelSkinLabel.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaInsets).offset(20)
        }
        
        createLogBtn.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        hStackButtonFeelSkin.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        feelBetterBtn.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.width.equalTo(150)
            make.left.equalTo(view.safeAreaInsets)
            
        }
        
        feelWorseBtn.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.width.equalTo(feelBetterBtn.snp.width)
            make.right.equalTo(view.safeAreaInsets)
        }
        
    }
    
    func navBar() {
        let button = UIButton(type: .custom)
            //Set the image
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            //Set the title
        button.setTitle(" ", for: .normal)
        //Add target
        button.addTarget(self, action: #selector(goToHomeRoutine), for: .touchUpInside)
        button.tintColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        button.sizeToFit()
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1), .font: UIFont(name: "Inter", size: 16)]
    }
    
    @objc func goToHomeRoutine() {
        let controller = RoutineHomeViewController()
        navigationController?.popViewController(animated: true)
    }



}
