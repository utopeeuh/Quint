//
//  NavigationBarUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 17/11/22.
//

import UIKit

class NavigationBarUIView: UIView {
    
    var lineWhiteRoutine = UIView()
    var lineWhiteSummary = UIView()
    var lineWhiteProgress = UIView()
    
    enum HistoryPage {
        case routine, summary, progress
    }
    
    public var selectedPage : HistoryPage = .routine {
        didSet{
            changeTabTo(selectedPage)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = K.Color.greenQuint
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    var routineButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .interSemiBold(size: 13)
        button.setTitle("Routine", for: .normal)
        button.setImage(UIImage(named: "calendarMonth"), for: .normal)
        return button
    }()
    
    var historyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .interSemiBold(size: 13)
        button.setTitle("History", for: .normal)
        button.setImage(UIImage(named: "receipt"), for: .normal)
        return button
    }()
    
    var progressButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .interSemiBold(size: 13)
        button.setTitle("Progress", for: .normal)
        button.setImage(UIImage(named: "receipt"), for: .normal)
        return button
    }()
    
    override func configureComponents() {
        self.addSubview(horizontalStack)
        self.addSubview(lineWhiteRoutine)
        self.addSubview(lineWhiteSummary)
        self.addSubview(lineWhiteProgress)
        
        lineWhiteSummary.backgroundColor = K.Color.whiteQuint
        lineWhiteRoutine.backgroundColor = K.Color.whiteQuint
        lineWhiteProgress.backgroundColor = K.Color.whiteQuint
        
        horizontalStack.addArrangedSubview(routineButton)
        horizontalStack.addArrangedSubview(historyButton)
        horizontalStack.addArrangedSubview(progressButton)
        
        routineButton.addTarget(self, action: #selector(goToRoutine), for: .touchUpInside)
        
        historyButton.addTarget(self, action: #selector(goToSummary), for: .touchUpInside)
        
        progressButton.addTarget(self, action: #selector(goToProgress), for: .touchUpInside)
    }
    
    override func configureLayout() {
        horizontalStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        
        lineWhiteRoutine.snp.makeConstraints { make in
            make.width.equalTo(routineButton.snp.width)
            make.left.bottom.equalToSuperview()
            make.height.equalTo(3)
        }
        
        lineWhiteSummary.snp.makeConstraints { make in
            make.width.equalTo(routineButton.snp.width)
            make.left.equalTo(lineWhiteRoutine.snp.right)
            make.bottom.equalToSuperview()
            make.height.equalTo(3)
        }
        
        lineWhiteProgress.snp.makeConstraints { make in
            make.width.equalTo(routineButton.snp.width)
            make.left.equalTo(lineWhiteSummary.snp.right)
            make.right.bottom.equalToSuperview()
            make.height.equalTo(3)
        }
        
        horizontalStack.arrangedSubviews.forEach { button in
            button.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(16)
                make.width.equalTo(UIScreen.main.bounds.width/3)
                make.height.equalToSuperview()
            }
            (button as? UIButton)?.alignVertical()
        }
    }
    
    func changeTabTo(_ page: HistoryPage){
        if page == .routine {
            lineWhiteProgress.isHidden = true
            lineWhiteSummary.isHidden = true
            progressButton.alpha = 0.6
            historyButton.alpha = 0.6
        }
        
        else if page == .summary {
            lineWhiteRoutine.isHidden = true
            lineWhiteProgress.isHidden = true
            routineButton.alpha = 0.6
            progressButton.alpha = 0.6
        }
        
        else {
            lineWhiteRoutine.isHidden = true
            lineWhiteSummary.isHidden = true
            routineButton.alpha = 0.6
            historyButton.alpha = 0.6
        }
    }
    
    @objc func goToRoutine(){
        replaceTopVC(with: RoutineHistoryVC())
    }
    
    @objc func goToSummary(){
        replaceTopVC(with: SummaryHistoryVC())
    }
    
    @objc func goToProgress(){
        replaceTopVC(with: ProgressHistoryVC())
    }
    
    private func replaceTopVC(with vc: UIViewController){
        var stack = UIApplication.topViewController()!.navigationController!.viewControllers
        stack.remove(at: stack.count - 1)
        stack.insert(vc, at: stack.count)
        UIApplication.topViewController()!.navigationController?.setViewControllers(stack, animated: false)
    }

}
