//
//  RoutineHomeViewController.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 04/10/22.
//
import CoreLocation
import UIKit
import WeatherKit


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
    
    private let UVLevelSuggestion: UILabel = {
        let label = UILabel()
        label.text = "Apply Sunscreen"
        label.textAlignment = .center
        label.textColor = .red
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.cornerRadius = 8
        label.layer.borderWidth = 1.0
//        label.isHidden = true
        return label
    }()


    private let UVLevelLabel: UILabel = {
        let label = UILabel()
        label.text = "UV LEVEL"
        label.textColor = .black
        return label
    }()

    private var UVLevelParameter: UILabel = {
        let label = UILabel()
        label.text = "MODERATE"
        label.textColor = .black
        return label
    }()

    private var UVLevelPoint: UILabel = {
        let label = UILabel()
        label.text = "4"
        label.textColor = .black
        label.textAlignment = .center
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.cornerRadius = 20
        label.layer.borderWidth = 1.0
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
                UVLevelParameter.text = String(describing: weather.currentWeather.uvIndex.category)
                UVLevelPoint.text = String(describing: weather.currentWeather.uvIndex.value)
                if weather.currentWeather.uvIndex.value >= 3{
                    UVLevelSuggestion.isHidden = false
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
        let targetSize = CGSize(width: 30, height: 30)
        var image = UIImage(systemName: "exclamationmark.circle.fill")?.withTintColor(.red)
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
        label.textColor = .black
        return label
    }()
    
    private lazy var hStackReminder: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.layer.borderColor = CGColor(red: 123/255, green: 123/255, blue: 123/255, alpha: 1)
        stackView.layer.borderWidth = 1.0
        stackView.layer.cornerRadius = 8.0
        return stackView
    }()
    
    private var todayRoutine: UILabel = {
        let label = UILabel()
        label.text = "Today's routines"
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private var routineTableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    func configureComponents() {
        vStackViewUV.addArrangedSubview(UVLevelLabel)
        vStackViewUV.addArrangedSubview(UVLevelParameter)
        
        hStackViewUV.addArrangedSubview(UVLevelPoint)
        hStackViewUV.addArrangedSubview(vStackViewUV)
        hStackViewUV.addArrangedSubview(UVLevelSuggestion)
        
        hStackReminder.addArrangedSubview(reminderIconView)
        hStackReminder.addArrangedSubview(reminderRoutine)
        
        mainStackView.addArrangedSubview(hStackViewUV)
        mainStackView.addArrangedSubview(hStackReminder)
        mainStackView.addArrangedSubview(todayRoutine)
    }
    
    func configureLayout() {
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
        
        UVLevelSuggestion.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(140)
            make.top.equalToSuperview().offset(7.5)
        }
        
        UVLevelLabel.snp.makeConstraints { make in
            make.leftMargin.equalTo(30)
        }
        
        UVLevelParameter.snp.makeConstraints { make in
            make.leftMargin.equalTo(30)
        }
        
        reminderIconView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets).offset(5)
            make.left.equalTo(view.safeAreaInsets).offset(5)
        }
        
        reminderRoutine.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets)
        }
        
        todayRoutine.snp.makeConstraints { make in
            make.top.equalTo(hStackReminder.snp.bottom).offset(25)
        }
        
        
        
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
