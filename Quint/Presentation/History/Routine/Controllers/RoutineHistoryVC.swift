//
//  RoutineHistoryVC.swift
//  Quint
//
//  Created by Vendly on 24/10/22.
//

import UIKit
import SnapKit
import CoreData

@available(iOS 16.0, *)
class RoutineHistoryVC: UIViewController {
    
    private var viewBlanket = UIView()
    private var calendarView = UICalendarView()
    private var expandButton = UIButton()
    private var scrollView = UIScrollView()
    private var noActivityView = NoActivityView()
    private var activityView = ActivityView()
    var logModel: LogModel?
    var selectedDate: Date?
    var navBar = NavigationBarUIView()
    var btnTes = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        refreshLogData(date: selectedDate!)
    }
    
    override func configureComponents() {
        
        view.backgroundColor = K.Color.bgQuint
        
        navBar.historyButton.setImage(UIImage(named: "receiptDisabled"), for: .normal)
        navBar.historyButton.setTitleColor(K.Color.disableBgBtnQuint, for: .normal)
        navBar.historyButton.addTarget(self, action: #selector(goToHistoryPage), for: .touchUpInside)
        navBar.lineWhiteHistory.isHidden = true
        
        viewBlanket.backgroundColor = K.Color.bgQuint
        
        calendarView.delegate = self
        calendarView.locale = .current
        
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        
        let selection = UICalendarSelectionSingleDate(delegate: self)
        selection.setSelected(Calendar.current.dateComponents([.year, .month, .day], from: Date.now), animated: false)
        selectedDate = Date.now
        
        calendarView.selectionBehavior = selection
        calendarView.tintColor = K.Color.greenQuint
        calendarView.fontDesign = .rounded
        calendarView.backgroundColor = K.Color.whiteQuint
        
        refreshLogData(date: selection.selectedDate!.date!)
        
        expandButton.setImage(UIImage(named: "arrow_down_icon"), for: .normal)
        expandButton.sizeToFit()
        expandButton.clipsToBounds = true
        expandButton.layer.cornerRadius = 13
        expandButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        expandButton.backgroundColor = K.Color.whiteQuint
        expandButton.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(expandButtonOnClick))
        expandButton.addGestureRecognizer(tap)
        
        expandButton.layer.masksToBounds = false
        expandButton.layer.shadowColor = K.Color.greyQuint.cgColor
        expandButton.layer.shadowOpacity = 0.1
        expandButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        expandButton.layer.shadowRadius = 7
        
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = K.Color.bgQuint
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 550)
        
        activityView.editButton.addTarget(self, action: #selector(goToDailyLog), for: .touchUpInside)
        noActivityView.logButton.addTarget(self, action: #selector(goToDailyLog), for: .touchUpInside)
        
    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: navBar,
                                    calendarView,
                                    viewBlanket,
                                    scrollView,
                                    expandButton)
        
        scrollView.addSubview(noActivityView)
        scrollView.addSubview(activityView)
        
        navBar.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(123)
        }
        
        calendarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(navBar.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.bottom.equalTo(viewBlanket.snp.bottom)
        }
        
        viewBlanket.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(calendarView).offset(125)
            make.width.equalToSuperview()
            make.height.equalTo(285)
        }
        
        expandButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(viewBlanket)
            make.width.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(expandButton.snp.bottom)
            make.bottom.equalTo(view)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        noActivityView.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }
        
        activityView.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }
        
    }
    
    @objc func expandButtonOnClick(sender: UITapGestureRecognizer){
        if viewBlanket.alpha == 1 {
            expandCalendar()
            return
        }
        collapseCalendar()
    }
    
    @objc func goToHistoryPage() {
        let controller = SummaryHistoryVC()
        navigationController?.pushViewController(controller, animated: false)
    }

    @objc func goToDailyLog(sender: UIButton) {
        
        if LogRepository.shared.doesLogExists(date: selectedDate ?? Date.now) == false {
            LogRepository.shared.createLog(date: selectedDate ?? Date.now)
        }
        
        let controller = DailyLogVC()
        
        controller.logDate = selectedDate

        if sender == activityView.editButton {
            controller.isEditingLog = true
        }
        
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.navigationBar.isHidden = true
    }

    func expandCalendar(){
        
        viewBlanket.backgroundColor = K.Color.whiteQuint
        
        UIView.animate(withDuration: 1.0, animations: { [self] in
            
            expandButton.transform = CGAffineTransformMakeTranslation(0, 285)
            scrollView.transform = CGAffineTransformMakeTranslation(0, 285)
            viewBlanket.alpha = 0
            
        }) { [self] completion in
            
            expandButton.setImage(UIImage(named: "arrow_up_icon"), for: .normal)
            expandButton.sizeToFit()
            scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 830)
            
        }
        
    }
    
    func collapseCalendar(){
        
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        expandButton.setImage(UIImage(named: "arrow_up_icon"), for: .normal)

        UIView.animate(withDuration: 1.0, animations: { [self] in
            
            expandButton.transform = CGAffineTransformMakeTranslation(0, 0)
            scrollView.transform = CGAffineTransformMakeTranslation(0, 0)
            viewBlanket.alpha = 1
            
        }) { [self] completion in
            
            expandButton.setImage(UIImage(named: "arrow_down_icon"), for: .normal)
            expandButton.sizeToFit()
            scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 550)
            viewBlanket.backgroundColor = K.Color.bgQuint
            
        }

    }
    
}

@available(iOS 16.0, *)
extension RoutineHistoryVC: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selectedDate = selection.selectedDate!.date!
        refreshLogData(date: selectedDate!)
    }
    
    func refreshLogData(date: Date){
        
        if LogRepository.shared.doesLogExists(date: date) {
            
            let currLog = LogRepository.shared.fetchLog(date: date)
            if currLog.isLogDone {
                noActivityView.isHidden = true
                activityView.isHidden = false
                
                logModel = LogRepository.shared.fetchLog(date: date)
                activityView.refreshData(logModel: logModel!)
                selectedDate = date
                
                return
            }
        }
        
        noActivityView.isHidden = false
        activityView.isHidden = true
        
    }
    
}

@available(iOS 16.0, *)
extension RoutineHistoryVC: RoutineDetailDelegate {
    func didTapFinish(time: K.RoutineTime) {
        return
    }
    
    func backFromLog(didCreate: Bool) {
        refreshLogData(date: selectedDate!)
        if didCreate {
            noActivityView.isHidden = true
            activityView.isHidden = false
        }
    }
    
    
}
