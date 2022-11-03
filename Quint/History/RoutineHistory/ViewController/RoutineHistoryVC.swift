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
    private var view1 = NoActivityView()
    private var view2 = ActivityView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func configureComponents() {
        
        view.backgroundColor = K.Color.bgQuint
        
        viewBlanket.backgroundColor = K.Color.bgQuint
        view.sendSubviewToBack(viewBlanket)
        detailSection.isUserInteractionEnabled = true

        calendarView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 0)
        calendarView.sizeToFit()

        calendarView.delegate = self
        calendarView.locale = .current
        
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar

        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection

        calendarView.tintColor = K.Color.greenQuint
        calendarView.fontDesign = .rounded
        calendarView.backgroundColor = K.Color.whiteQuint
        
        expandButton.clipsToBounds = true
        expandButton.layer.cornerRadius = 13
        expandButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        expandButton.backgroundColor = K.Color.whiteQuint
        expandButton.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(expandButtonOnClick))
        expandButton.addGestureRecognizer(tap)
        
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.7)
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        view1.isHidden = true
//        view2.isHidden = true
        view2.editButton.addTarget(self, action: #selector(goToEditLog), for: .touchUpInside)
        
        collapseDesc()
    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: calendarView,
                                    viewBlanket,
                                    scrollView,
                                    expandButton)
        
        detailSection.multipleSubviews(view: view1,
                                             view2)
        
        scrollView.addSubview(detailSection)
        
        calendarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.height.equalTo(415)
        }
        
        viewBlanket.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(calendarView).offset(215)
            make.width.equalToSuperview()
            make.height.equalTo(215)
        }
        
        expandButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(viewBlanket.snp.top).offset(-15)
            make.width.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(expandButton.snp.bottom)
            make.bottom.equalTo(view)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        view1.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        view2.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
    }
    
    @objc func expandButtonOnClick(sender: UITapGestureRecognizer){
        if calendarView.bounds.height < 415 {
            collapseDesc()
//            expandDesc()
            return
        }
        expandDesc()
//        collapseDesc()
    }
    
    @objc func goToEditLog() {
        let controller = AddNewStepUIViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func expandDesc(){
        
        calendarView.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.height.equalTo(200)
        }
        
        UIView.animate(withDuration: 1.0, animations: { [self] in
            detailSection.transform = CGAffineTransformMakeTranslation(0, 0)
            expandButton.transform = CGAffineTransformMakeTranslation(0, 0)
            viewBlanket.alpha = 1
        })

        expandButton.setImage(UIImage(named: "arrow_up_icon"), for: .normal)
        expandButton.sizeToFit()
        scrollView.contentSize.height = UIScreen.main.bounds.height / 1.7
        
    }

    func collapseDesc(){
        
        UIView.animate(withDuration: 1.0, animations: { [self] in
            detailSection.transform = CGAffineTransformMakeTranslation(0, 215)
            expandButton.transform = CGAffineTransformMakeTranslation(0, 215)
            viewBlanket.alpha = 0
        }) { completion in
            self.calendarView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide)
                make.width.equalToSuperview()
                make.height.equalTo(415)
            }
            
        }
        expandButton.setImage(UIImage(named: "arrow_down_icon"), for: .normal)
        expandButton.sizeToFit()
        scrollView.contentSize.height = UIScreen.main.bounds.height / 1.7
        
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
