//
//  RoutineHistoryVC.swift
//  Quint
//
//  Created by Vendly on 24/10/22.
//

import UIKit
import SnapKit

@available(iOS 16.0, *)
class RoutineHistoryVC: UIViewController {
    
//    private var historyRoutineView = HistoryRoutineView()
    private var detailSection = UIView()
    private var viewBlanket = UIView()
    private var calendarView = UICalendarView()
    private var expandButton = UIButton()
    private var scrollView = UIScrollView()
    private var noActivityView = NoActivityView()
    private var activityView = ActivityView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func configureComponents() {
        
        view.backgroundColor = K.Color.bgQuint
        
        viewBlanket.backgroundColor = K.Color.bgQuint
        detailSection.isUserInteractionEnabled = true
        detailSection.backgroundColor = K.Color.bgQuint
        
        calendarView.delegate = self
        calendarView.locale = .current
        
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar

        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection

        calendarView.tintColor = K.Color.greenQuint
        calendarView.fontDesign = .rounded
        calendarView.backgroundColor = K.Color.whiteQuint
        
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
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 500)
        
        noActivityView.isHidden = true
//        activityView.isHidden = true
        activityView.editButton.addTarget(self, action: #selector(goToEditLog), for: .touchUpInside)
        
    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: calendarView,
                                    viewBlanket,
                                    scrollView,
                                    expandButton)
        
        scrollView.addSubview(detailSection)
        
        detailSection.multipleSubviews(view: noActivityView,
                                             activityView)
        
        calendarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
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
        }
        
        activityView.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
    }
    
    @objc func expandButtonOnClick(sender: UITapGestureRecognizer){
        if viewBlanket.alpha == 1 {
            expandCalendar()
            return
        }
        collapseCalendar()
    }

    @objc func goToEditLog() {
        let controller = AddNewStepVC()
        self.navigationController?.pushViewController(controller, animated: true)
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
            scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 800)
            
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
            scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 500)
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
        print(dateComponents)
    }
    
}
