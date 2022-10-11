//
//  DailyLogViewController.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 11/10/22.
//

import UIKit

@available(iOS 16.0, *)
class DailyLogViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        self.title = "Daily skin log"
        navBar()
        ConfigureUI()
    }
    
    func ConfigureUI() {
        configureComponents()
        configureLayout()
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    override func configureComponents() {
    }
    
    override func configureLayout() {
        view.addSubview(mainStackView)
        
    }
    
    func navBar() {
        let button = UIButton(type: .custom)
            //Set the image
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            //Set the title
        button.setTitle(" ", for: .normal)
        //Add target
        button.addTarget(self, action: #selector(goToHomeRoutine), for: .touchUpInside)
        button.tintColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        button.sizeToFit()
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1), .font: UIFont(name: "Inter", size: 16)]
    }
    
    @objc func goToHomeRoutine() {
        let controller = RoutineHomeViewController()
        navigationController?.popViewController(animated: true)
    }



}
