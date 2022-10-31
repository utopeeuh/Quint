//
//  InsightResult.swift
//  Quint
//
//  Created by Vendly on 17/10/22.
//

import UIKit
import SnapKit

class OnboardingResultVC: UIViewController {
    
    var data : OnboardingData?
    private var titleLabel = UILabel()
    private var scrollView = UIScrollView()
    private var backButton = UIButton()
    private var photoResultView = PhotoResultView()
    private var resultTypeView = ResultTypeView()
    private var resultProblemView = ResultProblemView()
    private var recIngredientView = RecIngredientView()
    private var pageNumber = UILabel()
    private var nextButton = OnboardingButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultTypeView.setType(typeId: data!.selectedSkinType!)
        resultProblemView.setProblems(problemIds: data!.skinProblems!)
        recIngredientView.setIngredients(problemIds: data!.skinProblems!)
        
        configureUI()
    }
    
    override func configureComponents() {
        
        self.view.backgroundColor = K.Color.bgQuint
        
        backButton.setImage(UIImage(named: "close_icon"), for: .normal)
        backButton.addTarget(self, action: #selector(backOnClick), for: .touchUpInside)
        
        titleLabel.text = "Skin insights"
        titleLabel.font = .interMedium(size: 16)
        titleLabel.textColor = K.Color.blackQuint
        
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 1.8)
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        pageNumber.font = .interSemiBold(size: 14)
        let numberText = customizeColor(string: "1 ", color: K.Color.blackQuint)
        numberText.append(customizeColor(string: "of 2", color: K.Color.greyQuint))
        pageNumber.attributedText = numberText
        
        nextButton.setText("Next")
        nextButton.applyGradient(colours: [K.Color.greenLightQuint, K.Color.greenQuint], locations: [0,1], radius: 8)
        nextButton.addTarget(self, action: #selector(goToOnboardingSteps), for: .touchUpInside)
        
        // Set onboarding result data
        
        photoResultView.setImage(image: (data?.chosenImage ?? UIImage(named: "activeIcon"))!)
    }
    
    override func configureLayout() {

        view.multipleSubviews(view: backButton,
                                    titleLabel,
                                    scrollView)
        
        scrollView.multipleSubviews(view: photoResultView,
                                    resultTypeView,
                                    resultProblemView,
                                    recIngredientView,
                                    pageNumber,
                                    nextButton)
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(58)
            make.bottom.equalTo(view)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        photoResultView.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(400)
        }

        resultTypeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(photoResultView.snp.bottom).offset(19)
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(resultTypeView.frame.height)
        }

        resultProblemView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(resultTypeView.snp.bottom).offset(19)
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(resultProblemView.frame.height)
        }
        
        recIngredientView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(resultProblemView.snp.bottom).offset(19)
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(250)
        }
        
        pageNumber.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(recIngredientView.snp.bottom).offset(30)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.top.equalTo(pageNumber.snp.bottom).offset(34)
            make.height.equalTo(50)
        }
        
    }
    
    @objc func goToOnboardingSteps() {
        let vc = OnboardingStepsVC()
        vc.data = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func backOnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func customizeColor(string: String, color: UIColor) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: string, attributes:
            [NSAttributedString.Key.foregroundColor : color ])
    }
    
}
