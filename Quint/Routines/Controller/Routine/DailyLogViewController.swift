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
        label.font = .clashGroteskMedium(size: 20)
        label.textColor = .black
        return label
    }()
    
    private var sleepLabel: UILabel = {
        let label = UILabel()
        label.text = "How long did you sleep last night?"
        label.font = .clashGroteskMedium(size: 20)
        label.textColor = .black
        return label
    }()
    
    private var activityLabel: UILabel = {
        let label = UILabel()
        label.text = "What is your today's activity level?"
        label.font = .clashGroteskMedium(size: 20)
        label.textColor = .black
        return label
    }()
    
    private var feelSkinLabel: UILabel = {
        let label = UILabel()
        label.text = "How do you feel about your skin?"
        label.font = .clashGroteskMedium(size: 20)
        label.textColor = .black
        return label
    }()
    
    private let createLogBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .clashGroteskMedium(size: 18)
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
        button.titleLabel?.font = .interMedium(size: 16)
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
        button.titleLabel?.font = .interMedium(size: 16)
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
    
    private let sedentaryBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(K.Color.greenQuint, for: .normal)
        button.titleLabel?.font = .interSemi(size: 13)
        button.setImage(UIImage(named: "sedentaryIcon"), for: .normal)
        button.setTitle(" Sedentary", for: .normal)
        button.layer.cornerRadius = 8.0
        button.layer.borderColor = CGColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        button.layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.moveImageLeftTextCenter()
        return button
    }()
    
    private let activeBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(K.Color.greenQuint, for: .normal)
        button.titleLabel?.font = .interSemi(size: 13)
        button.setImage(UIImage(named: "activeIcon"), for: .normal)
        button.setTitle("    Active", for: .normal)
        button.layer.cornerRadius = 8.0
        button.layer.borderColor = CGColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        button.layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.moveImageLeftTextCenter()
        return button
    }()
    
    private let veryActiveBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(K.Color.greenQuint, for: .normal)
        button.titleLabel?.font = .interSemi(size: 13)
        button.setImage(UIImage(named: "veryActiveIcon"), for: .normal)
        button.setTitle(" Very Active", for: .normal)
        button.layer.cornerRadius = 8.0
        button.layer.borderColor = CGColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        button.layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.moveImageLeftTextCenter()
        return button
    }()
    
    @objc func sedentaryHandler() {
        sedentaryBtn.layer.borderWidth = 1.0
        activeBtn.layer.borderWidth = 0.0
        veryActiveBtn.layer.borderWidth = 0.0
    }
    
    @objc func activeHandler() {
        sedentaryBtn.layer.borderWidth = 0.0
        activeBtn.layer.borderWidth = 1.0
        veryActiveBtn.layer.borderWidth = 0.0
    }
    
    @objc func veryActiveHandler() {
        sedentaryBtn.layer.borderWidth = 0.0
        activeBtn.layer.borderWidth = 0.0
        veryActiveBtn.layer.borderWidth = 1.0
    }
    
    var sleepHours = sleepHourUIView()
    
    var sliderMood = moodSliderUIView()
    
    let step: Float = 20
    
    @objc func sliderValueDidChange(_ sender:UISlider!){
           
        // Use this code below only if you want UISlider to snap to values step by step
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        
        print("\(Int(roundedStepValue))")
        
        if roundedStepValue == 0.0 {
            sliderMood.moodDetail.text = "Stressed"
            sliderMood.moodSlider.setThumbImage(UIImage(named: "stressedEmoji"), for: .normal)
        }else if roundedStepValue == 20.0 {
            sliderMood.moodDetail.text = "Sad"
            sliderMood.moodSlider.setThumbImage(UIImage(named: "sadEmoji"), for: .normal)
        }else if roundedStepValue == 40.0 {
            sliderMood.moodDetail.text = "Nothing special"
            sliderMood.moodSlider.setThumbImage(UIImage(named: "neutralEmoji"), for: .normal)
        }else if roundedStepValue == 60.0 {
            sliderMood.moodDetail.text = "Happy"
            sliderMood.moodSlider.setThumbImage(UIImage(named: "happyEmoji"), for: .normal)
        }else if roundedStepValue == 80.0 {
            sliderMood.moodDetail.text = "Joyful"
            sliderMood.moodSlider.setThumbImage(UIImage(named: "joyfulEmoji"), for: .normal)
        }
   }
    
    override func configureComponents() {
        mainStackView.addArrangedSubview(moodLabel)
        mainStackView.addArrangedSubview(sliderMood)
        sliderMood.moodSlider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        
        mainStackView.addArrangedSubview(sleepLabel)
        mainStackView.addArrangedSubview(sleepHours)
        
        mainStackView.addArrangedSubview(activityLabel)
        mainStackView.addArrangedSubview(sedentaryBtn)
        sedentaryBtn.addTarget(self, action: #selector(sedentaryHandler), for: UIControl.Event.touchUpInside)
        mainStackView.addArrangedSubview(activeBtn)
        activeBtn.addTarget(self, action: #selector(activeHandler), for: UIControl.Event.touchUpInside)
        mainStackView.addArrangedSubview(veryActiveBtn)
        veryActiveBtn.addTarget(self, action: #selector(veryActiveHandler), for: UIControl.Event.touchUpInside)
        
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
        
        sedentaryBtn.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        activeBtn.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        veryActiveBtn.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        sleepHours.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        sliderMood.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
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
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1), .font: UIFont(name: "Inter-Medium", size: 16)]
    }
    
    @objc func goToHomeRoutine() {
        let controller = RoutineHomeViewController()
        navigationController?.popViewController(animated: true)
    }

}


