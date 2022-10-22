//
//  InsightResult.swift
//  Quint
//
//  Created by Vendly on 17/10/22.
//

import UIKit
import SnapKit

class OnboardingResultVC: UIViewController {
    
    private var titleLabel = UILabel()
    private var scrollView = UIScrollView()
    private var view1 = PhotoResultView()
    private var view2 = ResultTypeView()
    private var view3 = ResultProblemView()
    private var view4 = RecIngredientView()
    private var nextButton = OnboardingButton()
    
    // page indexing as follows
//    private var childContents: [UIView] = [
//        PhotoResultView(),
//        ResultTypeView(),
//        ResultProblemView(),
//        RecIngredientView()
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func configureComponents() {
        
        self.view.backgroundColor = K.Color.bgQuint
        
        titleLabel.text = "Skin insights"
        titleLabel.font = .interMedium(size: 16)
        titleLabel.textColor = K.Color.blackQuint
        
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 1.8)
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        nextButton.setText("Next")
        nextButton.applyGradient(colours: [K.Color.greenLightQuint, K.Color.greenQuint], locations: [0,1], radius: 8)
        nextButton.addTarget(self, action: #selector(goToOnboardingSteps), for: .touchUpInside)
        
    }
    
    override func configureLayout() {

        view.multipleSubviews(view: titleLabel,
                                    scrollView)
        
        scrollView.multipleSubviews(view: view1, view2,
                                          view3, view4,
                                          nextButton)
        
        // layouting child view content
//        childContents.forEach {
//            scrollView.addSubview($0)
//        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(view)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        view1.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(400)
        }

        view2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view1.snp.bottom).offset(19)
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(208)
        }

        view3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view2.snp.bottom).offset(19)
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(468)
        }
        
        view4.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view3.snp.bottom).offset(19)
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(250)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.top.equalTo(view4.snp.bottom).offset(50)
            make.height.equalTo(50)
        }
        
    }
    
    @objc func goToOnboardingSteps() {
        let controller = OnboardingStepsVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
