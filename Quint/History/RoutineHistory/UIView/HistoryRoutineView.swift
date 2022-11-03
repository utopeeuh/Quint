//
//  HistoryRoutineView.swift
//  Quint
//
//  Created by Vendly on 24/10/22.
//

import UIKit
import SnapKit

@available(iOS 16.0, *)
class HistoryRoutineView: UIView {
    
    private var calendarView = UICalendarView()
    private var descTruncHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureComponents() {
        
        calendarView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 0)
        calendarView.sizeToFit()
        descTruncHeight = calendarView.bounds.height
        
        calendarView.delegate = self
        calendarView.calendar = .current
        calendarView.locale = .current
        
        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection
        
        calendarView.tintColor = K.Color.greenQuint
        calendarView.fontDesign = .rounded
        calendarView.layer.cornerRadius = 13
        calendarView.backgroundColor = K.Color.whiteQuint
        
    }
    
    override func configureLayout() {

        addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
//            make.width.equalToSuperview()
        }
        
    }
    
}

@available(iOS 16.0, *)
extension HistoryRoutineView: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        print(dateComponents)
    }
    
    
}
