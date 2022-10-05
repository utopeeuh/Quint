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

class TreatmentsVC: UIViewController {
    
    private var vstack = UIStackView()
    private var segmentedControl = UISegmentedControl(items: ["Products", "Ingredients"])
    private var productView = ProductView()
    private var ingredientView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configureUI()
    }
    
    @objc func changeTab(sender: UISegmentedControl) {
        print("Switched tabs")
        switch sender.selectedSegmentIndex {
        case 0:
            productView.isHidden = false
            ingredientView.isHidden = true
            self.view.backgroundColor = UIColor.red
        default:
            productView.isHidden = true
            ingredientView.isHidden = false
            self.view.backgroundColor = UIColor.purple
        }
    }
    
    func configureComponents(){
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(changeTab), for: .valueChanged)
        
        productView.backgroundColor = UIColor.black
        ingredientView.backgroundColor = UIColor.yellow
    }
    
    func configureLayout(){
        view.addSubview(segmentedControl)
        view.addSubview(productView)
        view.addSubview(ingredientView)
        
        segmentedControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        productView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
        
        ingredientView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func configureUI() {
        configureComponents()
        configureLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
