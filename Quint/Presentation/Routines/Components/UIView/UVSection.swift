//
//  UVSection.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/11/22.
//

import Foundation
import UIKit
import SnapKit
import CoreLocation
import WeatherKit

@available(iOS 16.0, *)
class UVSection: UIView, CLLocationManagerDelegate{
    
    var height: CGFloat = 70
    let locationManager = CLLocationManager()
    let service = WeatherService()
    
    private let warningIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "WarningUVIcon")
        imageView.isHidden = false
        return imageView
    }()

    private let applySuncreenLbl: UILabel = {
        let label = UILabel()
        label.text = "Apply your Sunscreen"
        label.font = .interSemiBold(size: 12)
        label.textAlignment = .center
        label.textColor = UIColor(red: 242/255, green: 53/255, blue: 53/255, alpha: 1)
        label.numberOfLines = 0
        label.isHidden = false
        return label
    }()

    private let UVLevelLbl: UILabel = {
        let label = UILabel()
        label.text = "UV LEVEL"
        label.font = .interMedium(size: 12)
        label.textColor = UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1)
        return label
    }()

    private var UVLevelDetailLbl: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        label.font = .interSemiBold(size: 16)
        return label
    }()

    private var UVLevelPoint = UVPointView()
    
    required init() {
        super.init(frame: .zero)
        backgroundColor = .white
        layer.cornerRadius = 8
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func configureComponents() {
        UVLevelDetailLbl.text = "Low"
        UVLevelPoint.setNumber(0)
        UVLevelPoint.applyGradient(colours: [K.Color.greenLightQuint, K.Color.greenQuint], locations: [0,1], radius: 20)
    }
    
    override func configureLayout() {
        multipleSubviews(view: UVLevelPoint, UVLevelLbl, UVLevelDetailLbl, warningIcon, applySuncreenLbl)
        
        UVLevelPoint.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        UVLevelLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.left.equalTo(UVLevelPoint.snp.right).offset(12)
        }
        
        UVLevelDetailLbl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-14)
            make.left.equalTo(UVLevelPoint.snp.right).offset(12)
        }
        
        applySuncreenLbl.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-14)
        }
        
        warningIcon.snp.makeConstraints { make in
            make.centerY.equalTo(applySuncreenLbl)
            make.right.equalTo(applySuncreenLbl.snp.left).offset(-6)
        }
    }
    
    func getUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func getWeather(location: CLLocation){
        Task {
            do {
                let weather = try await service.weather(for: location)
                UVLevelDetailLbl.text = String(describing: weather.currentWeather.uvIndex.category)
                UVLevelPoint.setNumber(weather.currentWeather.uvIndex.value)
                
                if weather.currentWeather.uvIndex.value >= 3{
                    warningIcon.isHidden = false
                    applySuncreenLbl.isHidden = false
                }
                
                var lightColor: UIColor?
                var darkColor: UIColor?
                
                if weather.currentWeather.uvIndex.value <= 1 {
                    lightColor = K.Color.greenLightQuint
                    darkColor = K.Color.greenQuint
                }else if weather.currentWeather.uvIndex.value > 1 && weather.currentWeather.uvIndex.value <= 3 {
                    lightColor = K.Color.yellowLightQuint
                    darkColor = K.Color.yellowQuint
                }else if weather.currentWeather.uvIndex.value > 3 && weather.currentWeather.uvIndex.value <= 6 {
                    lightColor = K.Color.orangeLightQuint
                    darkColor = K.Color.orangeQuint
                }else if weather.currentWeather.uvIndex.value > 6 && weather.currentWeather.uvIndex.value <= 8 {
                    lightColor = K.Color.redLightQuint
                    darkColor = K.Color.redQuint
                }else if weather.currentWeather.uvIndex.value > 8 && weather.currentWeather.uvIndex.value <= 11 {
                    lightColor = K.Color.purpleLightQuint
                    darkColor = K.Color.purpleQuint
                }
                
                UVLevelPoint.applyGradient(colours: [lightColor!, darkColor!], locations: [0,1], radius: 20)
                
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.first else {
            return
        }
        locationManager.stopUpdatingLocation()
        getWeather(location: location)
    }    
}
