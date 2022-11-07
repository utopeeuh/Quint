//
//  RoutineVC.swift
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
class RoutineVC: UIViewController, CLLocationManagerDelegate{

    private var whiteTopBar = UIView()
    private var uvSection = UVSection()
    private var reminderView = ReminderUIView()
    
    private var routineLbl = UILabel()
    private var morningRoutine = MorningRoutineCell()
    private var nightRoutine = NightRoutineCell()
    private var logRoutine = LogRoutineCell()
    
    private lazy var routineCellsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    private var dailyTips = DailySkincareTips()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        uvSection.getUserLocation()
    }


    override func configureComponents() {
        
        whiteTopBar.backgroundColor = .white
        
        routineLbl.text = "Today's routines"
        routineLbl.font = .clashGroteskMedium(size: 20)
        
        // morning routine
        let morningGesture = UITapGestureRecognizer(target: self, action: #selector(goToMorningRoutine))
        morningRoutine.addGestureRecognizer(morningGesture)
        morningRoutine.currStack = routineCellsStack
        
        let nightGesture = UITapGestureRecognizer(target: self, action: #selector(goToNightRoutine))
        nightRoutine.addGestureRecognizer(nightGesture)
        nightRoutine.currStack = routineCellsStack
        
        let logGesture = UITapGestureRecognizer(target: self, action: #selector(goToDailyLog))
        logRoutine.addGestureRecognizer(logGesture)
        logRoutine.currStack = routineCellsStack
        
        // MARK: - ROUTINE
        routineCellsStack.addArrangedSubview(morningRoutine)
        routineCellsStack.addArrangedSubview(nightRoutine)
        routineCellsStack.addArrangedSubview(logRoutine)
        
        routineCellsStack.arrangedSubviews.forEach { view in
            if let v = view as? RoutineCell{
                v.delegate = self
            }
        }
    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: whiteTopBar, uvSection, reminderView, routineLbl, routineCellsStack, dailyTips)
        
        whiteTopBar.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        uvSection.snp.makeConstraints { make in
            make.top.equalTo(whiteTopBar.snp.bottom).offset(-3)
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(70)
        }
        
        reminderView.snp.makeConstraints { make in
            make.height.equalTo(reminderView.height)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width-40)
            make.top.equalTo(uvSection.snp.bottom).offset(28)
//            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        routineLbl.snp.makeConstraints { make in
            make.top.equalTo(reminderView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
        }
        
        routineCellsStack.snp.makeConstraints { make in
            make.top.equalTo(routineLbl.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width-40)
            make.height.equalTo(60*3+24)
        }
        
        routineCellsStack.arrangedSubviews.forEach { subview in
            subview.snp.makeConstraints { make in
                make.height.equalTo(60)
                make.width.equalToSuperview()
                make.centerX.equalToSuperview()
            }
        }
        
        dailyTips.snp.makeConstraints { make in
            make.height.equalTo(dailyTips.height)
            make.width.equalTo(UIScreen.main.bounds.width-40)
            make.centerX.equalToSuperview()
            make.top.equalTo(routineCellsStack.snp.bottom).offset(48)
        }
    }
    
    @objc func goToDailyLog(sender: UITapGestureRecognizer) {
        let controller = DailyLogVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func goToMorningRoutine(sender: UITapGestureRecognizer) {
        let controller = RoutineDetailVC()
        controller.routineTime = .morning
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func goToNightRoutine(sender: UITapGestureRecognizer) {
        let controller = RoutineDetailVC()
        controller.routineTime = .night
        navigationController?.pushViewController(controller, animated: true)
    }
}

@available(iOS 16.0, *)
extension RoutineVC: RoutineReminderDelegate{
    func hideRoutineReminder() {
        
        if reminderView.isHidden == true{
            return
        }
        
        reminderView.hide()
        
        let moveUpHeight = -(reminderView.height + 40)
        
        let moveViews = [routineLbl, routineCellsStack, dailyTips]
        UIView.animate(withDuration: 0.4, animations: {
            moveViews.forEach { view in
                view.transform = CGAffineTransform(translationX: 0, y: moveUpHeight)
            }
        })
    }
}
 

