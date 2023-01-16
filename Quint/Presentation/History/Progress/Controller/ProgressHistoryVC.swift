//
//  ProgressHistoryVC.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/12/22.
//

import Foundation
import UIKit
import SnapKit

class ProgressHistoryVC: UIViewController {
    
    private let statusBarBg = UIView()
    
    private let dateIterator = DateIterator()
    
    private let watchButton = WatchButton()
    
    private let progressCollection = ProgressCollectionView()
    
    var navBar = NavigationBarUIView()
    
    private var logs: [LogModel] = [] {
        didSet {
            progressCollection.setSource(logs)
            if logs.isEmpty {
                watchButton.isHidden = true
            } else {
                watchButton.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.Color.bgQuint
        configureUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
        
        dateIterator.delegate = self
        
        logs = LogRepository.shared.fetchLogListWithImage(dateStart: dateIterator.currDate, dateEnd: Calendar.current.endOfMonth(dateIterator.currDate))
    }
    
    override func configureComponents() {
        
        navBar.selectedPage = .progress
        
        statusBarBg.backgroundColor = .white
        
        watchButton.addTarget(self, action: #selector(watchProgressOnClick), for: .touchUpInside) 
        
        view.multipleSubviews(view: navBar, statusBarBg, dateIterator, watchButton, progressCollection)
    }
    
    override func configureLayout() {
        
        navBar.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(123)
        }
        
        statusBarBg.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.width.equalToSuperview()
            make.bottom.equalTo(dateIterator.snp.top)
        }
        
        dateIterator.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(dateIterator.frame.height)
        }
        
        watchButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(watchButton.frame.height)
            make.top.equalTo(dateIterator.snp.bottom).offset(20)
        }
        
        progressCollection.snp.makeConstraints { make in
            make.top.equalTo(watchButton.snp.bottom).offset(20)
            make.width.equalToSuperview().offset(-20)
            make.bottom.centerX.equalToSuperview()
        }
    }
    
    @objc private func watchProgressOnClick(){
        print("watch progress")
        let controller = ProgressSlideshowVC()
        controller.logs = logs
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ProgressHistoryVC: DateIteratorDelegate {
    func dateIterator(willDisplay date: Date) {
        logs = LogRepository.shared.fetchLogListWithImage(dateStart: date, dateEnd: Calendar.current.endOfMonth(date))
    }
}
