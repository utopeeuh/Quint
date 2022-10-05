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
    private var scrollView: UIScrollView!
    private var cats = ["1", "2", "3", "4"]
//    private var prodCategries = CategoriesScrollableView()
//    private var ingredientView = IngredientVC()
    private var feedView = FeedsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configureUI()
    }
    
    @objc func changeTab(sender: UISegmentedControl) {
        print("Switched tabs")
        switch sender.selectedSegmentIndex {
        case 0:
            cats = ["1", "2", "3", "4"]
//            productView.isHidden = false
//            ingredientView.isHidden = true
            self.view.backgroundColor = UIColor.red
        default:
            cats = ["a", "b", "c", "d"]
//            productView.isHidden = true
//            ingredientView.isHidden = false
            self.view.backgroundColor = UIColor.purple
        }
        
        for view in scrollView.subviews{
            view.removeFromSuperview()
        }
        addHorizontalTeamList()
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    override func configureComponents(){
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(changeTab), for: .valueChanged)
        scrollView = UIScrollView(frame: CGRect(x: 0,y: 0, width: view.frame.width, height: 60))
//        productView.backgroundColor = UIColor.black
//        ingredientView.backgroundColor = UIColor.yellow
    }
    
    override func configureLayout(){
        view.addSubview(segmentedControl)
        view.addSubview(scrollView)
        view.addSubview(feedView)
        
        segmentedControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        addHorizontalTeamList()
        
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(K.Offset.sm)
            make.height.equalTo(60)
            make.left.equalToSuperview().offset(K.Offset.sm)
            make.right.equalToSuperview()
        }
        
        feedView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(K.Offset.sm)
            make.centerX.bottom.equalToSuperview()
            make.width.equalToSuperview().offset(-K.Offset.md)
        }
        
//        productView.snp.makeConstraints { make in
//            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
//            make.left.right.bottom.equalToSuperview()
//        }
//
    }
    
    func addHorizontalTeamList() {

        scrollView.backgroundColor = UIColor.yellow
        var frame : CGRect?

        for i in 0..<cats.count {
            let button = UIButton(type: .custom)
            frame = CGRect(x: CGFloat(i * 140), y: 10, width: 130, height: 40)

            button.frame = frame!
            button.tag = i
            button.backgroundColor = .black
            button.addTarget(self, action: #selector(selectTeam), for: .touchUpInside)
            button.setTitle(cats[i], for: .normal)
            print(cats[i])
            scrollView.addSubview(button)
        }

        scrollView.contentSize = CGSize( width: CGFloat(130*cats.count), height: scrollView.frame.size.height)
        scrollView.backgroundColor = .white
    }

    @objc func selectTeam() {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
