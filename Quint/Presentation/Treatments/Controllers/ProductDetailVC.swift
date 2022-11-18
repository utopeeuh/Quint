//
//  ProductDetailVC.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 13/10/22.
//

import Foundation
import UIKit
import SnapKit

@available(iOS 16.0, *)
class ProductDetailVC: UIViewController{
    
    private var mainScrollView = UIScrollView()
    
    private let viewTitle = UILabel()
    private let backBtn = UIButton(type: .custom)
    
    private var segmentedControl = UISegmentedControl(items: ["Ingredients", "Precaution"])
    
    private var topSection : ProductDetailTopView!
    private var ingredientSegment : IngredientSegmentView!
    private var precautionSegment : PrecautionSegmentView!
    
    // Animations
    private var zero: CGAffineTransform!
    private var moveLeft: CGAffineTransform!
    private var moveRight: CGAffineTransform!
    
    var product: ProductModel! {
        didSet{
            configureUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        zero = CGAffineTransform(translationX: 0.0, y: 0.0)
        moveLeft = CGAffineTransform(translationX: -(self.view.bounds.width * 1), y: 0.0)
        moveRight = CGAffineTransform(translationX: (self.view.bounds.width * 1), y: 0.0)
    }
    
    override func configureComponents() {
        
        view.backgroundColor = K.Color.bgQuint
        view.isUserInteractionEnabled = true
        
        mainScrollView.showsVerticalScrollIndicator = false
        
        viewTitle.font = .interMedium(size: 16)
        viewTitle.text = "Product detail"

        backBtn.setImage(UIImage(named: "arrow_back"), for: .normal)
        backBtn.setTitle("", for: .normal)
        backBtn.sizeToFit()
        backBtn.addTarget(self, action: #selector(backOnClick), for: .touchUpInside)
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(changeTab), for: .valueChanged)
        
        topSection = ProductDetailTopView(product: product)

        precautionSegment = PrecautionSegmentView(product: product)
        precautionSegment.isUserInteractionEnabled = true
        
        ingredientSegment = IngredientSegmentView(product: product)
        
        mainScrollView.multipleSubviews(view: backBtn, viewTitle, topSection, segmentedControl, ingredientSegment, precautionSegment)
    }
    
    override func configureLayout() {
        view.addSubview(mainScrollView)
        
        backBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(11)
            make.size.equalTo(24)
        }
        
        viewTitle.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn)
            make.centerX.equalToSuperview()
        }
        
        topSection.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.bottom).offset(9)
            make.width.equalTo(mainScrollView)
            make.height.equalTo(topSection.getTotalHeight())
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.centerX.equalTo(mainScrollView)
            make.top.equalTo(topSection.snp.bottom).offset(32)
            make.width.equalTo(mainScrollView).offset(-40)
            make.height.equalTo(segmentedControl.frame.height)
        }
        
        ingredientSegment.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(36)
            make.width.height.equalTo(mainScrollView)
        }
        
        precautionSegment.transform = moveRight
        precautionSegment.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(36)
            make.width.height.equalTo(mainScrollView)
        }
        
        mainScrollView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
        
        mainScrollView.contentSize.height = mainScrollView.contentSize.height + 36 + segmentedControl.frame.height
        
        changeTab(sender: segmentedControl)
    }
    
    @objc func changeTab(sender: UISegmentedControl) {
        print("Switched tabs")
        
        switch sender.selectedSegmentIndex {
        case 0:
            ingredientSegment.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {
                self.ingredientSegment.transform = self.zero
                self.precautionSegment.transform = self.moveRight
            }) { [self] completion in
                precautionSegment.isHidden = true
                mainScrollView.contentSize.height  = ingredientSegment.getTotalHeight() + 36 + segmentedControl.frame.height + topSection.getTotalHeight() + 32 + 62
            }
            
        default:
            precautionSegment.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {
                self.ingredientSegment.transform = self.moveLeft
                self.precautionSegment.transform = self.zero
            }) { [self] completion in
                ingredientSegment.isHidden = true
                mainScrollView.contentSize.height  = precautionSegment.getTotalHeight() + 36 + segmentedControl.frame.height + topSection.getTotalHeight() + 32 + 62
            }
        }
    }
    
    @objc func backOnClick(){
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
