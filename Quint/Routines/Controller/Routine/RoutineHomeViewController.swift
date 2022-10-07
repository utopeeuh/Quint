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
class RoutineHomeViewController: UIViewController, CLLocationManagerDelegate {
    
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
    
    private lazy var hStackReminder: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.layer.backgroundColor = CGColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        stackView.layer.cornerRadius = 8.0
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
        morningRoutine.btnId = 1
        
        nightRoutine.leftBtn.setImage(UIImage(systemName: "circle"), for: .normal)
        nightRoutine.imageRoutine.image = UIImage(named: "iconNight")
        nightRoutine.chevRight.image = UIImage(systemName: "chevron.right")
        nightRoutine.titleRoutine.text = "Night routine     "
        nightRoutine.btnId = 2
        
        logRoutine.leftBtn.setImage(UIImage(systemName: "lock"), for: .normal)
        logRoutine.imageRoutine.image = UIImage(named: "iconLog")
        logRoutine.titleRoutine.text = "Daily skin condition log"

        
        mainStackView.addArrangedSubview(morningRoutine)
        mainStackView.addArrangedSubview(nightRoutine)
        mainStackView.addArrangedSubview(logRoutine)
        mainStackView.addArrangedSubview(productGuide)
        
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
            
//        mainStackView.snp.makeConstraints { make in
//            make.top.right.bottom.left.equalToSuperview()
//        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.first else {
            return
        }
        locationManager.stopUpdatingLocation()
        getWeather(location: location)
    }
    
    
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

}

extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}

@available(iOS 16.0, *)
class RoutineUIView: UIView {
    
    var btnId: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8.0
        self.isUserInteractionEnabled = true
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
        setupConstraints()
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

