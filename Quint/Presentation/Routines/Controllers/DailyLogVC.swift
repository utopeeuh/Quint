//
//  DailyLogVC.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 11/10/22.
//

import Foundation
import UIKit
import SnapKit

@available(iOS 16.0, *)
class DailyLogVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    private let mainScrollView = UIScrollView()
    
    var faceImage : UIImage?
    private var logData = LogData()
    
    private var activityButtons : [UIView] = []
    private var feelButtons : [UIView] = []
    
    var delegate : RoutineDetailDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        self.title = "Daily skin log"
        
        activityButtons = [sedentaryBtn, activeBtn, veryActiveBtn]
        feelButtons = [feelBetterBtn, feelWorseBtn]
        
        navBar()
        configureUI()
        
        feelBetterHandler()
        sedentaryHandler()
    }
    
    private var mainContainer = UIView()
    
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
        return button
    }()
    
    private lazy var feelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var activityStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    private var feelBetterBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(K.Color.greenQuint, for: .normal)
        button.titleLabel?.font = .interMedium(size: 16)
        button.setImage(UIImage(systemName: "hand.thumbsup.fill")?.withTintColor(K.Color.greenQuint, renderingMode: .alwaysOriginal), for: .normal)
        button.setTitle(" Better", for: .normal)
        button.layer.cornerRadius = 8.0
        button.layer.borderColor = CGColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        button.applyGradient(colours: [UIColor.clear, UIColor.clear], locations: [0, 1], radius: 8)
        button.layer.borderWidth = 1.0
        return button
    }()
    
    private var feelWorseBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(K.Color.greenQuint, for: .normal)
        button.titleLabel?.font = .interMedium(size: 16)
        button.setImage(UIImage(systemName: "hand.thumbsdown.fill")?.withTintColor(K.Color.greenQuint, renderingMode: .alwaysOriginal), for: .normal)
        button.setTitle(" Worsen", for: .normal)
        button.layer.cornerRadius = 8.0
        button.layer.borderColor = CGColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        button.applyGradient(colours: [UIColor.clear, UIColor.clear], locations: [0, 1], radius: 8)
        button.layer.borderWidth = 1.0
        return button
    }()
    
    @objc func feelBetterHandler() {
        logData.isBetter = true
        selectFeel(feelBetterBtn)
        deselectFeel(feelWorseBtn)
    }
    
    @objc func feelWorseHandler() {
        logData.isBetter = false
        selectFeel(feelWorseBtn)
        deselectFeel(feelBetterBtn)
    }
    
    func selectFeel(_ btn: UIButton){
        btn.setTitleColor(.white, for: .normal)
        
        btn.backgroundColor = UIColor(patternImage: UIImage(named: "ButtonGreenBackground")!)
            
        if(btn == feelBetterBtn){
            btn.setImage(UIImage(systemName: "hand.thumbsup.fill")?.withTintColor(K.Color.whiteQuint, renderingMode: .alwaysOriginal), for: .normal)
        }
        else{
            btn.setImage(UIImage(systemName: "hand.thumbsdown.fill")?.withTintColor(K.Color.whiteQuint, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    
    func deselectFeel(_ btn: UIButton){
        btn.setTitleColor(K.Color.greenQuint, for: .normal)
        
        btn.backgroundColor = UIColor.clear
        
        
        if(btn == feelBetterBtn){
            btn.setImage(UIImage(systemName: "hand.thumbsup.fill")?.withTintColor(K.Color.greenQuint, renderingMode: .alwaysOriginal), for: .normal)
        }
        else{
            btn.setImage(UIImage(systemName: "hand.thumbsdown.fill")?.withTintColor(K.Color.greenQuint, renderingMode: .alwaysOriginal), for: .normal)
        }
        
    }
    
    private let sedentaryBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(K.Color.greenQuint, for: .normal)
        button.titleLabel?.font = .interSemiBold(size: 13)
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
        button.titleLabel?.font = .interSemiBold(size: 13)
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
        button.titleLabel?.font = .interSemiBold(size: 13)
        button.setImage(UIImage(named: "veryActiveIcon"), for: .normal)
        button.setTitle(" Very Active", for: .normal)
        button.layer.cornerRadius = 8.0
        button.layer.borderColor = CGColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        button.layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.moveImageLeftTextCenter()
        return button
    }()
    
    @objc func sedentaryHandler() {
        logData.activityLevel = K.ActivityLevel.sedentary
        sedentaryBtn.layer.borderWidth = 1.5
        activeBtn.layer.borderWidth = 0.0
        veryActiveBtn.layer.borderWidth = 0.0
    }
    
    @objc func activeHandler() {
        logData.activityLevel = K.ActivityLevel.active
        sedentaryBtn.layer.borderWidth = 0.0
        activeBtn.layer.borderWidth = 1.5
        veryActiveBtn.layer.borderWidth = 0.0
    }
    
    @objc func veryActiveHandler() {
        logData.activityLevel = K.ActivityLevel.veryActive
        sedentaryBtn.layer.borderWidth = 0.0
        activeBtn.layer.borderWidth = 0.0
        veryActiveBtn.layer.borderWidth = 1.5
    }
    
    var sleepHours = SleepHourUIView()
    
    var sliderMood = MoodSliderUIView()
    
    let step: Float = 20
    
    @objc func sliderValueDidChange(_ sender:UISlider!){
           
        // Use this code below only if you want UISlider to snap to values step by step
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        
        print("\(Int(roundedStepValue))")
        
        if roundedStepValue == 0.0 {
            sliderMood.moodDetail.text = "Stressed"
            sliderMood.moodSlider.setThumbImage(UIImage(named: "stressedEmoji"), for: .normal)
            logData.moodId = K.Mood.stressed
        }else if roundedStepValue == 20.0 {
            sliderMood.moodDetail.text = "Sad"
            sliderMood.moodSlider.setThumbImage(UIImage(named: "sadEmoji"), for: .normal)
            logData.moodId = K.Mood.sad
        }else if roundedStepValue == 40.0 {
            sliderMood.moodDetail.text = "Nothing special"
            sliderMood.moodSlider.setThumbImage(UIImage(named: "neutralEmoji"), for: .normal)
            logData.moodId = K.Mood.nothing
        }else if roundedStepValue == 60.0 {
            sliderMood.moodDetail.text = "Happy"
            sliderMood.moodSlider.setThumbImage(UIImage(named: "happyEmoji"), for: .normal)
            logData.moodId = K.Mood.happy
        }else if roundedStepValue == 80.0 {
            sliderMood.moodDetail.text = "Joyful"
            sliderMood.moodSlider.setThumbImage(UIImage(named: "joyfulEmoji"), for: .normal)
            logData.moodId = K.Mood.joyful
        }
   }
    
    override func configureComponents() {
        
        
        mainScrollView.isUserInteractionEnabled = true
        mainScrollView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.height)
        mainScrollView.contentSize.height = 990
        mainScrollView.showsVerticalScrollIndicator = false
        
        sliderMood.moodSlider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        
        activityButtons.forEach { view in
            activityStack.addArrangedSubview(view)
        }
        sedentaryBtn.addTarget(self, action: #selector(sedentaryHandler), for: UIControl.Event.touchUpInside)
        activeBtn.addTarget(self, action: #selector(activeHandler), for: UIControl.Event.touchUpInside)
        veryActiveBtn.addTarget(self, action: #selector(veryActiveHandler), for: UIControl.Event.touchUpInside)
        
        feelButtons.forEach { view in
            feelStack.addArrangedSubview(view)
        }
        feelBetterBtn.addTarget(self, action: #selector(feelBetterHandler), for: UIControl.Event.touchUpInside)
        feelWorseBtn.addTarget(self, action: #selector(feelWorseHandler), for: UIControl.Event.touchUpInside)
        
        feelBetterBtn.frame = CGRect(x: 0, y: 0, width: 150, height: 45)
        feelWorseBtn.frame = CGRect(x: 0, y: 0, width: 150, height: 45)
        
        createLogBtn.frame = CGRect(x: 0, y: 0, width: 352, height: 45)
        createLogBtn.applyGradient(colours: [K.Color.greenLightQuint, K.Color.greenQuint], locations: [0, 1], radius: 8)
        createLogBtn.addTarget(self, action: #selector(createLog), for: .touchUpInside)
    }
    
    override func configureLayout() {
        
        view.addSubview(mainScrollView)
        
        mainScrollView.multipleSubviews(view:
                                moodLabel,
                                sliderMood,
                                sleepLabel,
                                sleepHours,
                                activityLabel,
                                activityStack,
                                feelSkinLabel,
                                feelStack,
                                createLogBtn
        )
        
        mainScrollView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width-40)
            make.centerX.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        moodLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
        }
        
        sliderMood.snp.makeConstraints { make in
            make.top.equalTo(moodLabel.snp.bottom).offset(18)
            make.height.equalTo(128)
            make.width.equalToSuperview()
        }
        
        sleepLabel.snp.makeConstraints { make in
            make.top.equalTo(sliderMood.snp.bottom).offset(50)
        }
        
        sleepHours.snp.makeConstraints { make in
            make.top.equalTo(sleepLabel.snp.bottom).offset(18)
            make.width.equalToSuperview()
            make.height.equalTo(134)
        }
        
        activityLabel.snp.makeConstraints { make in
            make.top.equalTo(sleepHours.snp.bottom).offset(50)
        }
        
        activityStack.snp.makeConstraints { make in
            make.top.equalTo(activityLabel.snp.bottom).offset(18)
            make.width.equalToSuperview()
            make.height.equalTo(204)
        }
        
        feelSkinLabel.snp.makeConstraints { make in
            make.top.equalTo(activityStack.snp.bottom).offset(50)
        }
        
        feelStack.snp.makeConstraints { make in
            make.top.equalTo(feelSkinLabel.snp.bottom).offset(18)
            make.width.equalToSuperview()
            make.height.equalTo(48)
        }
        
        createLogBtn.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(feelStack.snp.bottom).offset(72)
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
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1), .font: UIFont(name: "Inter-Medium", size: 16)!]
    }
    
    @objc func goToHomeRoutine() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func createLog(){
        logData.image = faceImage
        logData.sleep = sleepHours.getSleepNumber()
        LogRepository.shared.updateLogData(date: Date.now, logData: logData)
        
        navigationController?.popViewController(animated: true)
        
        delegate?.didCreateLog()
    }

}


