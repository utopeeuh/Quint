//
//  ProductDetailVC.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 13/10/22.
//

import Foundation
import UIKit
import SnapKit

class ProductDetailVC: UIViewController{
    
    private var mainScrollView = UIScrollView()
    
    private var segmentedControl = UISegmentedControl(items: ["Ingredients", "Precaution"])
    
    private var topSection = ProductDetailTopView()
    
    private var ingredientSegment = IngredientSegmentView()
    
    private var precautionSegment = PrecautionSegmentView()
    
    // Animations
    private var zero: CGAffineTransform!
    private var moveLeft: CGAffineTransform!
    private var moveRight: CGAffineTransform!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zero = CGAffineTransform(translationX: 0.0, y: 0.0)
        moveLeft = CGAffineTransform(translationX: -(self.view.bounds.width * 1), y: 0.0)
        moveRight = CGAffineTransform(translationX: (self.view.bounds.width * 1), y: 0.0)
    
        configureUI()
    }
    
    override func configureComponents() {
        
        mainScrollView.showsVerticalScrollIndicator = false
        
        view.backgroundColor = K.Color.bgQuint
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(changeTab), for: .valueChanged)
        
        view.isUserInteractionEnabled = true
        precautionSegment.isUserInteractionEnabled = true
        
        mainScrollView.addSubview(topSection)
        mainScrollView.addSubview(segmentedControl)
        mainScrollView.addSubview(ingredientSegment)
        mainScrollView.addSubview(precautionSegment)
    }
    
    override func configureLayout() {
        view.addSubview(mainScrollView)
        
        topSection.snp.makeConstraints { make in
            make.top.equalTo(mainScrollView)
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
        
        print(UIScreen.main.bounds.height)
        print(precautionSegment.getTotalHeight())
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
                mainScrollView.contentSize.height  = ingredientSegment.getTotalHeight() + 36 + segmentedControl.frame.height + topSection.getTotalHeight() + 32
            }
            
        default:
            precautionSegment.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {
                self.ingredientSegment.transform = self.moveLeft
                self.precautionSegment.transform = self.zero
            }) { [self] completion in
                ingredientSegment.isHidden = true
                mainScrollView.contentSize.height  = precautionSegment.getTotalHeight() + 36 + segmentedControl.frame.height + topSection.getTotalHeight() + 32
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
