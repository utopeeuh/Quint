//
//  InsightSteps.swift
//  Quint
//
//  Created by Vendly on 17/10/22.
//

import UIKit
import SnapKit

@available(iOS 16.0, *)
class OnboardingStepsVC: UIViewController {
    
    var data : OnboardingData?
    private var backButton = BackButton()
    private var headerLabel = UILabel()
    private var titleLabel = UILabel()
    private var scrollView = UIScrollView()
    private var stepsContainer = StepContainerView()
    private var pageNumber = UILabel()
    private var nextButton = OnboardingButton()
    private var textHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func configureComponents() {
        
        self.view.backgroundColor = K.Color.bgQuint
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        backButton.addTarget(self, action: #selector(backOnClick), for: .touchUpInside)
        
        headerLabel.text = "Skin insights"
        headerLabel.font = .interMedium(size: 16)
        headerLabel.textColor = K.Color.blackQuint
        
        titleLabel.font = .clashGroteskMedium(size: 30)
        titleLabel.textColor = K.Color.blackQuint
        titleLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 0)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.text = "Skincare steps you need to follow based on your current skin condition"
        textHeight = titleLabel.requiredHeight
        titleLabel.sizeToFit()
        
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 800)
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        stepsContainer.setSteps(categoryIds: data!.routineCategoryList)
        
        pageNumber.font = .interSemiBold(size: 14)
        let numberText = customizeColor(string: "2 ", color: K.Color.blackQuint)
        numberText.append(customizeColor(string: "of 2", color: K.Color.greyQuint))
        pageNumber.attributedText = numberText
        
        nextButton.setText("Next")
        nextButton.applyGradient(colours: [K.Color.greenLightQuint, K.Color.greenQuint], locations: [0,1], radius: 8)
        nextButton.addTarget(self, action: #selector(goToHome), for: .touchUpInside)

    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: backButton,
                                    headerLabel,
                                    scrollView)

        scrollView.multipleSubviews(view: titleLabel,
                                    stepsContainer,
                                          pageNumber,
                                          nextButton)

        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(60)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel).offset(60)
            make.bottom.equalTo(view)
            make.width.equalTo(UIScreen.main.bounds.width)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.width.equalToSuperview().offset(-40)
        }
        
        stepsContainer.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(titleLabel.snp.bottom).offset(36)
            make.width.equalToSuperview().offset(-40)
        }

        pageNumber.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stepsContainer.snp.bottom).offset(30)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(pageNumber.snp.bottom).offset(36)
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(50)
        }
        
    }
    
    @objc func goToHome() {
        
        // Save onboarding data
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.main.async {
            DataHelper.shared.saveOnboardingData(data: self.data!)
            group.leave()
        }
        
        group.notify(queue: .main){
            // Generate recommended products
            ProductsRepository.shared.generateRecommendedProducts()
        }
        
        // Change userdefaults
        UserDefaults.standard.set(true, forKey: K.UD.hasDoneOnboarding)
        
        // Set routine as root vc
        let vc = TabBarVC()
        let foregroundedScenes = UIApplication.shared.connectedScenes.filter { $0.activationState == .foregroundActive }
        let window = foregroundedScenes.map { $0 as? UIWindowScene }.compactMap { $0 }.first?.windows.filter { $0.isKeyWindow }.first
        
        guard let uWindow = window else { return }

        uWindow.rootViewController = vc
        UIView.transition(with: uWindow, duration: 0.3, options: [.transitionCrossDissolve], animations: {}, completion: nil)
    }
    
    @objc func backOnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func customizeColor(string: String, color: UIColor) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: string, attributes:
            [NSAttributedString.Key.foregroundColor : color ])
    }
    
}
