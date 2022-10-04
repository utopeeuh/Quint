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
        label.isHidden = true
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
        label.text = ""
        label.textColor = .black
        return label
    }()

    private var UVLevelPoint: UILabel = {
        let label = UILabel()
        label.text = ""
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
                if weather.currentWeather.uvIndex.value == 0{
                    UVLevelSuggestion.isHidden = false
                }
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    func configureComponents() {
        vStackView.addArrangedSubview(UVLevelLabel)
        vStackView.addArrangedSubview(UVLevelParameter)
        
        hStackView.addArrangedSubview(UVLevelPoint)
        hStackView.addArrangedSubview(vStackView)
        hStackView.addArrangedSubview(UVLevelSuggestion)
    }
    
    
    
    func configureLayout() {
//        view.addSubview(UVLevelLabel)
//        view.addSubview(UVLevelParameter)
//        view.addSubview(UVLevelPoint)
//        view.addSubview(UVLevelSuggestion)
//
//
//
//        UVLevelLabel.snp.makeConstraints { make in
//            make.left.equalTo(view.safeAreaLayoutGuide).offset(70)
//            make.top.equalTo(40)
//        }
//
//        UVLevelParameter.snp.makeConstraints { make in
//            make.left.equalTo(70)
//            make.top.equalTo(UVLevelLabel).offset(20)
//        }
//
//        UVLevelPoint.snp.makeConstraints { make in
//            make.left.equalTo(20)
//            make.top.equalTo(UVLevelLabel).offset(2)
//            make.width.equalTo(40)
//            make.height.equalTo(40)
//        }
//
//        UVLevelSuggestion.snp.makeConstraints { make in
//            make.right.equalTo(-20)
//            make.top.equalTo(UVLevelLabel).offset(10)
//            make.height.equalTo(25)
//        }
        
        view.addSubview(hStackView)
        hStackView.snp.makeConstraints { make in
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
