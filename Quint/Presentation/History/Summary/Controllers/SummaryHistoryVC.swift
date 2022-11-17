//
//  SummaryHistoryVC.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 24/10/22.
//

import UIKit

@available(iOS 16.0, *)
class SummaryHistoryVC: UIViewController {
    var vwDropDown = DropDownUIView()
    var spacer = UIView()
    var spacer2 = UIView()
    var morningRoutine = MorningUIView()
    var nightRoutine = NightUIView()
    var sleep = SleepUIView()
    var moodLevel = MoodLevelUIView()
    var activityLevel = ActivityLevelUIView()
    let monthYearPickerView = MonthYearWheelPicker()
    var logList: [LogModel] = []
    var navBar = NavigationBarUIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        logList = LogRepository.shared.fetchLogList(dateStart: Calendar.current.startOfMonth(Date.now), dateEnd: Calendar.current.startOfDay(for: Date.now))
        morningRoutine.logList = logList
        nightRoutine.logList = logList
        sleep.logList = logList
        moodLevel.logList = logList
        activityLevel.logList = logList
        configureUI()
    }
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollStackViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    @objc func dropDownHandler() {
        spacer.isHidden = false
        monthYearPickerView.isHidden = false
        monthYearPickerView.onDateSelected = { (month, year) in
            var string: String!
            switch month {
                case 1:
                    string = String("January \(year)")
                case 2:
                    string = String("February \(year)")
                case 3:
                    string = String("March \(year)")
                case 4:
                    string = String("April \(year)")
                case 5:
                    string = String("May \(year)")
                case 6:
                    string = String("June \(year)")
                case 7:
                    string = String("July \(year)")
                case 8:
                    string = String("August \(year)")
                case 9:
                    string = String("September \(year)")
                case 10:
                    string = String("October \(year)")
                case 11:
                    string = String("November \(year)")
                case 12:
                    string = String("Desember \(year)")
                default:
                    string = String("\(month) \(year)")
            }

            self.vwDropDown.lblTitle.text = string

        }
        monthYearPickerView.frame = CGRect(x: 0, y: 0, width: 350, height: 350)
        scrollView.addSubview(monthYearPickerView)
        monthYearPickerView.backgroundColor = K.Color.disableBgBtnQuint
        monthYearPickerView.layer.cornerRadius = 10.0
        monthYearPickerView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(45)
            make.height.equalTo(150)
            make.width.equalTo(350)
        }
        monthYearPickerView.addTarget(self, action: #selector(monthYearWheelPickerDidChange), for: .valueChanged)
    }
    
    @objc private func monthYearWheelPickerDidChange() {
        let date = monthYearPickerView.date
        print(date)
        if Calendar.current.startOfMonth(date) == Calendar.current.startOfMonth(Date.now) {
            logList = LogRepository.shared.fetchLogList(dateStart: Calendar.current.startOfMonth(Date.now), dateEnd: Calendar.current.startOfDay(for: Date.now))
        }else {
            logList = LogRepository.shared.fetchLogList(dateStart: Calendar.current.startOfMonth(date), dateEnd: Calendar.current.endOfMonth(date))
        }
        
        morningRoutine.logList = logList
        nightRoutine.logList = logList
        sleep.logList = logList
        moodLevel.logList = logList
        activityLevel.logList = logList
        
    }
    
    @objc func anyWhereHandler() {
        monthYearPickerView.isHidden = true
        spacer.isHidden = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1400)
    }
    
    @objc func goToRoutinePage() {
        let controller = RoutineHistoryVC()
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func configureComponents() {
        view.addSubview(navBar)
        navBar.routineButton.setImage(UIImage(named: "calendarMonthDisabled"), for: .normal)
        navBar.routineButton.setTitleColor(K.Color.disableBgBtnQuint, for: .normal)
        navBar.routineButton.addTarget(self, action: #selector(goToRoutinePage), for: .touchUpInside)
        navBar.lineWhiteRoutine.isHidden = true
        
        view.addSubview(scrollView)
        let touchAnyWhereGesture = UITapGestureRecognizer(target: self, action: #selector(anyWhereHandler))
        view.addGestureRecognizer(touchAnyWhereGesture)
        scrollView.addSubview(scrollStackViewContainer)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1400)
        
        scrollView.addSubview(vwDropDown)
        vwDropDown.lblTitle.text = "November 2022"
        vwDropDown.dropDownIconView.image = UIImage(named: "arrowDown")
        let dropDownGesture = UITapGestureRecognizer(target: self, action: #selector(dropDownHandler))
        vwDropDown.addGestureRecognizer(dropDownGesture)
        
        scrollStackViewContainer.addArrangedSubview(spacer)
        spacer.isHidden = true

        scrollStackViewContainer.addArrangedSubview(morningRoutine)
        scrollStackViewContainer.addArrangedSubview(nightRoutine)
        scrollStackViewContainer.addArrangedSubview(sleep)
        scrollStackViewContainer.addArrangedSubview(moodLevel)
        scrollStackViewContainer.addArrangedSubview(activityLevel)
        scrollStackViewContainer.addArrangedSubview(spacer2)
    }
    
    override func configureLayout() {
        navBar.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(123)
        }
        
        vwDropDown.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(30)
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
        morningRoutine.snp.makeConstraints { make in
            make.height.equalTo(220)
        }
        
        nightRoutine.snp.makeConstraints { make in
            make.height.equalTo(220)
        }
        
        sleep.snp.makeConstraints { make in
            make.height.equalTo(220)
        }
        
        moodLevel.snp.makeConstraints { make in
            make.height.equalTo(250)
        }
        
        activityLevel.snp.makeConstraints { make in
            make.height.equalTo(220)
        }
        
        scrollView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height)
            make.top.equalTo(navBar.snp.bottom).offset(10)
        }
        
        scrollStackViewContainer.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(1265)
            make.top.equalTo(vwDropDown.snp.bottom).offset(15)
        }
        
        spacer.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        
        spacer2.snp.makeConstraints { make in
            make.height.equalTo(25)
        }
    }

}
