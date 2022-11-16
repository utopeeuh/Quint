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
    
    private var scrollView = UIScrollView()
    
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
        
        navigationController?.isNavigationBarHidden = true

        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool){
        // Fade in products
        productListView.fadeIn()

        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: productListView.height+120)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
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
                self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 452)
            }
        }
    }
    
    override func configureComponents(){
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(changeTab), for: .valueChanged)
        
        scrollView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        productListView.delegate = self
    }
    
    override func configureLayout(){
        view.addSubview(scrollView)
        
        scrollView.multipleSubviews(view: segmentedControl, productListView, ingredientListView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
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

extension TreatmentsVC: ProductListDelegate {
    func updateContentHeight(height: CGFloat) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: height+120)
        print(height)
    }
}
