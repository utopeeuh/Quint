//
//  ViewController.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 03/10/22.
//
import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

class TreatmentsVC: UIViewController{

    private var vstack = UIStackView()
    private var segmentedControl = UISegmentedControl(items: ["Products", "Ingredients"])
    
    private var productListView = ProductListView()
    private var ingredientListView = IngredientListView()
    
    // Animations
    private var zero: CGAffineTransform!
    private var moveLeft: CGAffineTransform!
    private var moveRight: CGAffineTransform!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.Color.bgQuint
    
        zero = CGAffineTransform(translationX: 0.0, y: 0.0)
        moveLeft = CGAffineTransform(translationX: -(self.view.bounds.width * 1), y: 0.0)
        moveRight = CGAffineTransform(translationX: (self.view.bounds.width * 1), y: 0.0)

        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool){
        // Fade in products
        productListView.fadeIn()
    }
    
    @objc func changeTab(sender: UISegmentedControl) {
        print("Switched tabs")
        
        switch sender.selectedSegmentIndex {
        case 0:
            productListView.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {
                self.productListView.transform = self.zero
                self.ingredientListView.transform = self.moveRight
            }) { completion in
                self.ingredientListView.isHidden = true
            }
        default:
            ingredientListView.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {
                self.productListView.transform = self.moveLeft
                self.ingredientListView.transform = self.zero
            }) { completion in
                self.productListView.isHidden = true
            }
        }
    }
    
    override func configureComponents(){
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(changeTab), for: .valueChanged)
    }
    
    override func configureLayout(){
        view.addSubview(segmentedControl)
        view.addSubview(productListView)
        view.addSubview(ingredientListView)
        
        segmentedControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(37)
            make.width.equalToSuperview().offset(-40)
        }
        
        productListView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(36)
            make.width.bottom.equalToSuperview()
        }
        
        ingredientListView.transform = moveRight
        ingredientListView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(36)
            make.width.bottom.equalToSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
