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
    private var topLabelStack = UIStackView()
    private var topLabel = UILabel()
    private var scrollView: UIScrollView!
    private var categories = K.Category.product
    private var productListView = ProductListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.Color.bgQuint

        configureUI()
    }
    
    @objc func changeTab(sender: UISegmentedControl) {
        print("Switched tabs")
        switch sender.selectedSegmentIndex {
        case 0:
            categories = K.Category.product
            topLabel.text = "Recommended products"
//            productView.isHidden = false
//            ingredientView.isHidden = true
        default:
            categories = K.Category.ingredient
            topLabel.text = "Recommended ingredients"
//            productView.isHidden = true
//            ingredientView.isHidden = false
        }
        
        for view in scrollView.subviews{
            view.removeFromSuperview()
        }
        addTopCategories()
        scrollView.setContentOffset(CGPoint(x: -20, y: 0), animated: true)
    }
    
    override func configureComponents(){
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(changeTab), for: .valueChanged)
        
        topLabelStack.axis = .horizontal
        topLabelStack.alignment = .fill
        
        topLabel.text = "Recommended products"
        topLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        scrollView = UIScrollView(frame: CGRect(x: 0,y: 0, width: view.frame.width, height: 60))
        scrollView.backgroundColor = K.Color.bgQuint
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        topLabelStack.addArrangedSubview(topLabel)
//        productView.backgroundColor = UIColor.black
//        ingredientView.backgroundColor = UIColor.yellow
    }
    
    override func configureLayout(){
        view.addSubview(segmentedControl)
        view.addSubview(topLabelStack)
        view.addSubview(scrollView)
        view.addSubview(productListView)
        
        segmentedControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().offset(-40)
        }
        
        topLabelStack.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(36)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        addTopCategories()
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(topLabelStack.snp.bottom).offset(K.Offset.sm)
            make.height.equalTo(60)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        productListView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(K.Offset.sm)
            make.centerX.bottom.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
        }
        
//        productView.snp.makeConstraints { make in
//            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
//            make.left.right.bottom.equalToSuperview()
//        }
//
    }
    
    func addTopCategories() {
        var totalWidth = 0

        for i in 0..<categories.count {
            let button = CategoryButton(categoryId: i+1, totalWidth: totalWidth, index: i)

            button.frame = CGRect(x: totalWidth+K.Offset.sm*2*i, y: 10, width: 130, height: 40)
            
            button.addTarget(self, action: #selector(selectTopCategory), for: .touchUpInside)
            button.setText(categories[i+1])
            totalWidth = totalWidth + Int(button.frame.width)
            scrollView.addSubview(button)
        }

        scrollView.contentSize = CGSize( width: CGFloat(totalWidth+8*categories.count), height: scrollView.frame.size.height)
        scrollView.showsHorizontalScrollIndicator = false
    }

    @objc func selectTopCategory(_ sender: CategoryButton) {
        for view in scrollView.subviews as [UIView] {
            if let btn = view as? CategoryButton {
                btn.backgroundColor = K.Color.whiteQuint
                btn.setTitleColor(K.Color.greenQuint, for: .normal)
            }
        }
        sender.backgroundColor = K.Color.greenQuint
        sender.setTitleColor(K.Color.whiteQuint, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
