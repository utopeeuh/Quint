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
                if weather.currentWeather.uvIndex.value >= 3{
                    UVLevelSuggestion.isHidden = false
                }
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    var hStack = UIStackView()
    
    func configureComponents() {
        hStack.axis = .horizontal
        hStack.alignment = .fill
        hStack.addArrangedSubview(UVLevelPoint)
        hStack.addArrangedSubview(UVLevelParameter)
        hStack.addArrangedSubview(UVLevelLabel)
        hStack.addArrangedSubview(UVLevelSuggestion)
        hStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureLayout() {
        view.addSubview(UVLevelLabel)
        view.addSubview(UVLevelParameter)
        view.addSubview(UVLevelPoint)
        view.addSubview(UVLevelSuggestion)
        
        

        UVLevelLabel.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(70)
            make.top.equalTo(40)
        }

        UVLevelParameter.snp.makeConstraints { make in
            make.left.equalTo(70)
            make.top.equalTo(UVLevelLabel).offset(20)
        }

        UVLevelPoint.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(UVLevelLabel).offset(2)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }

        UVLevelSuggestion.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.top.equalTo(UVLevelLabel).offset(10)
            make.height.equalTo(25)
        }
        
//        view.addSubview(hStack)
//        hStack.snp.makeConstraints { make in
//            make.left.right.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
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
        
        let superview = self.view
        let navbar = UIView()
        
        superview?.addSubview(navbar)
        navbar.backgroundColor = .white
        navbar.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(90)
            make.width.equalTo(superview!)
        }
        configureComponents()
        configureLayout()
        
    }
    

}
