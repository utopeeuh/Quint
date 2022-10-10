//
//  RoutineHomeViewController.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 04/10/22.
//
import CoreLocation
import UIKit
import WeatherKit
import RxCocoa
import RxSwift
import RxDataSources

@available(iOS 16.0, *)
class RoutineHomeViewController: UIViewController, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    let service = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        ConfigureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserLocation()
    }
    
    
    private let UVLevelSuggestionIcon: UIImageView = {
        let imageView = UIImageView()
        let targetSize = CGSize(width: 10, height: 10)
        var image = UIImage(named: "Vector")?.withTintColor(UIColor(red: 242/255, green: 53/255, blue: 53/255, alpha: 1))
        let scaledImage = image?.scalePreservingAspectRatio(
            targetSize: targetSize
        )
        imageView.image = scaledImage
        imageView.isHidden = true
        return imageView
    }()

    private let UVLevelSuggestion: UILabel = {
        let label = UILabel()
        label.text = "Apply your Sunscreen"
        label.font = label.font.withSize(12)
        label.textAlignment = .center
        label.textColor = UIColor(red: 242/255, green: 53/255, blue: 53/255, alpha: 1)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()


    private let UVLevelLabel: UILabel = {
        let label = UILabel()
        label.text = "UV LEVEL"
        label.font = label.font.withSize(12)
        label.textColor = UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1)
        return label
    }()

    private var UVLevelParameter: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private var UVLevelPoint: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 20
        return label
    }()

    func getUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func getWeather(location: CLLocation){
        Task {
            do {
                let weather = try await service.weather(for: location)
                print("UV INDEX: " + String(describing: weather.currentWeather.uvIndex))
                UVLevelParameter.text = String(describing: weather.currentWeather.uvIndex.category)
                UVLevelPoint.text = String(describing: weather.currentWeather.uvIndex.value)
                if weather.currentWeather.uvIndex.value >= 3{
                    UVLevelSuggestion.isHidden = false
                    UVLevelSuggestionIcon.isHidden = false
                }
                
                if weather.currentWeather.uvIndex.value <= 1 {
                    UVLevelPoint.layer.backgroundColor = CGColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
                }else if weather.currentWeather.uvIndex.value > 1 && weather.currentWeather.uvIndex.value <= 3 {
                    UVLevelPoint.layer.backgroundColor = CGColor(red: 255/255, green: 211/255, blue: 99/255, alpha: 1)
                    UVLevelPoint.textColor = UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1)
                }else if weather.currentWeather.uvIndex.value > 3 && weather.currentWeather.uvIndex.value <= 6 {
                    UVLevelPoint.layer.backgroundColor = CGColor(red: 255/255, green: 150/255, blue: 73/255, alpha: 1)
                }else if weather.currentWeather.uvIndex.value > 6 && weather.currentWeather.uvIndex.value <= 8 {
                    UVLevelPoint.layer.backgroundColor = CGColor(red: 255/255, green: 99/255, blue: 99/255, alpha: 1)
                }else if weather.currentWeather.uvIndex.value > 8 && weather.currentWeather.uvIndex.value <= 11 {
                    UVLevelPoint.layer.backgroundColor = CGColor(red: 168/255, green: 99/255, blue: 255/255, alpha: 1)
                }
                
                
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    private lazy var hStackViewUV: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var vStackViewUV: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    private let reminderIconView: UIImageView = {
        let imageView = UIImageView()
        let targetSize = CGSize(width: 20, height: 20)
        var image = UIImage(systemName: "exclamationmark.circle.fill")?.withTintColor(UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1))
        let scaledImage = image?.scalePreservingAspectRatio(
            targetSize: targetSize
        )
        imageView.image = scaledImage
        return imageView
    }()
    
    private var reminderRoutine: UILabel = {
        let label = UILabel()
        label.text = "Unlock today skin condition log by finishing at least one routine"
        label.numberOfLines = 0
        label.textColor = UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1)
        label.font = label.font.withSize(14)
        return label
    }()
    
    lazy var hStackReminder: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.layer.backgroundColor = CGColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        stackView.layer.cornerRadius = 8.0
        stackView.isHidden = false
        return stackView
    }()
    
    private var todayRoutine: UILabel = {
        let label = UILabel()
        label.text = "Today's routines"
        label.numberOfLines = 0
        label.font = label.font.withSize(20)
        label.textColor = .black
        return label
    }()
    
    private var productGuide: UILabel = {
        let label = UILabel()
        label.text = "Product usage guide"
        label.numberOfLines = 0
        label.font = label.font.withSize(20)
        label.textColor = .black
        return label
    }()
    
    var morningRoutine = RoutineUIView()
    
    var nightRoutine = RoutineUIView()
    
    var logRoutine = RoutineUIView()
    
    private var scrollView = HorizontalScrollButtons()
    private var categories = K.Category.productGuide
    private var categoriesImage = K.Category.productGuideImageName
    
    var dailyTips = DailySkincareTips()
    
    func ConfigureUI() {
        let navbar = UIView()
        navbar.backgroundColor = .white
        self.view.addSubview(navbar)
        navbar.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.topLayoutGuide.snp.top)
            make.bottom.equalTo(self.topLayoutGuide.snp.bottom)
        }
        configureComponents()
        configureLayout()
    }

    override func configureComponents() {
        
        vStackViewUV.addArrangedSubview(UVLevelLabel)
        vStackViewUV.addArrangedSubview(UVLevelParameter)
        
        hStackViewUV.addArrangedSubview(UVLevelPoint)
        hStackViewUV.addArrangedSubview(vStackViewUV)
        
        hStackViewUV.addArrangedSubview(UVLevelSuggestionIcon)
        hStackViewUV.addArrangedSubview(UVLevelSuggestion)
        
        hStackReminder.addArrangedSubview(reminderIconView)
        hStackReminder.addArrangedSubview(reminderRoutine)

        mainStackView.addArrangedSubview(hStackViewUV)
        mainStackView.addArrangedSubview(hStackReminder)
        mainStackView.addArrangedSubview(todayRoutine)

        morningRoutine.leftBtn.setImage(UIImage(systemName: "circle"), for: .normal)
        morningRoutine.imageRoutine.image = UIImage(named: "iconMorning")
        morningRoutine.chevRight.image = UIImage(systemName: "chevron.right")
        morningRoutine.titleRoutine.text = "Morning routine"
        let morningGesture = UITapGestureRecognizer(target: self, action: #selector(goToMorningRoutine))
        morningRoutine.addGestureRecognizer(morningGesture)
        morningRoutine.btnId = 1
        morningRoutine.currStack = mainStackView
        morningRoutine.currPosition = 1
        morningRoutine.name = "morning"
        
        nightRoutine.leftBtn.setImage(UIImage(systemName: "circle"), for: .normal)
        nightRoutine.imageRoutine.image = UIImage(named: "iconNight")
        nightRoutine.chevRight.image = UIImage(systemName: "chevron.right")
        nightRoutine.titleRoutine.text = "Night routine"
        nightRoutine.btnId = 2
        nightRoutine.currStack = mainStackView
        nightRoutine.currPosition = 2
        nightRoutine.name = "night"
        
        logRoutine.leftBtn.setImage(UIImage(systemName: "lock"), for: .normal)
        logRoutine.leftBtn.isEnabled = true
        logRoutine.imageRoutine.image = UIImage(named: "iconLog")
        logRoutine.titleRoutine.text = "Daily skin condition log"
        logRoutine.btnId = 3
        logRoutine.currStack = mainStackView
        logRoutine.currPosition = 3
        logRoutine.name = "log"
        
        // MARK: - ROUTINE
        mainStackView.addArrangedSubview(morningRoutine)
        mainStackView.addArrangedSubview(nightRoutine)
        mainStackView.addArrangedSubview(logRoutine)
        mainStackView.addArrangedSubview(productGuide)
        
        // Generate buttons for top scroll
        var catButtons: [SmallCategoryButtonGuide] = []
        for i in 0..<categories.count {
            let button = SmallCategoryButtonGuide(categoryId: i+1)
            button.addTarget(self, action: #selector(selectTopCategory), for: .touchUpInside)
            button.setText(categories[i+1])
            button.setImageCategory(categoriesImage[i+1])
            button.centerVertically()
            catButtons.append(button)
        }
        scrollView.setButtons(catButtons)
        
        mainStackView.addArrangedSubview(scrollView)
        mainStackView.addArrangedSubview(dailyTips)
        
    }
    
    @objc func goToMorningRoutine(sender: UITapGestureRecognizer) {
        let controller = MorningRoutinesViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func configureLayout() {
        view.addSubview(mainStackView)
        
        hStackViewUV.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.top.equalTo(view.safeAreaInsets).offset(40)
        }
        
        UVLevelPoint.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalToSuperview()
        }
        
        UVLevelSuggestionIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.width.equalTo(11)
            make.height.equalTo(9.5)
        }

        UVLevelSuggestion.snp.makeConstraints { make in
            make.height.equalTo(26)
            make.width.equalTo(135)
            make.top.equalToSuperview().offset(15)
            make.right.equalTo(view.safeAreaInsets).offset(-16)
        }
        
        UVLevelLabel.snp.makeConstraints { make in
            make.leftMargin.equalTo(15)
            make.top.equalTo(view.safeAreaInsets).offset(3.5)
        }
        
        UVLevelParameter.snp.makeConstraints { make in
            make.leftMargin.equalTo(15)
        }
        
        hStackReminder.snp.makeConstraints { make in
            make.height.equalTo(66)
        }
        
        reminderIconView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets).offset(23.5)
            make.left.equalTo(view.safeAreaInsets).offset(16)
        }
        
        reminderRoutine.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets).offset(17.5)
            make.left.equalTo(reminderIconView.snp.right).offset(12)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-100)
        }
        
        todayRoutine.snp.makeConstraints { make in
            make.top.equalTo(hStackReminder.snp.bottom).offset(25)
        }
        
        morningRoutine.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        
        nightRoutine.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        
        logRoutine.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(productGuide.snp.bottom).offset(16)
            make.height.equalTo(144)
            make.width.equalTo(120)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        dailyTips.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.width.equalTo(300)
        }
        
//        mainStackView.snp.makeConstraints { make in
//            make.top.right.bottom.left.equalToSuperview()
//        }
        
    }
    
    @objc func selectTopCategory() {
        print("TES!!!!")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.first else {
            return
        }
        locationManager.stopUpdatingLocation()
        getWeather(location: location)
    }
}

