//
//  AddNewStepUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 17/10/22.
//

import UIKit

@available(iOS 16.0, *)
class AddNewStepUIViewController: UIViewController {
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
        self.title = "Daily skin log"
        navBar()
        ConfigureUI()
    }
    
    func navBar() {
        let button = UIButton(type: .custom)
            //Set the image
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
            //Set the title
        button.setTitle(" ", for: .normal)
        //Add target
        button.addTarget(self, action: #selector(goToDetailRoutine), for: .touchUpInside)
        button.tintColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        button.sizeToFit()
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1), .font: UIFont(name: "Inter", size: 16)]
    }
    
    @objc func goToDetailRoutine() {
        let controller = MorningRoutinesViewController()
        navigationController?.popViewController(animated: true)
    }
    
    func ConfigureUI() {
        let navbar = UIView()
        navbar.backgroundColor = .white
        self.view.addSubview(navbar)
        navbar.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.topLayoutGuide.snp.top)
            make.bottom.equalTo(self.topLayoutGuide.snp.bottom)
        }
        configureComponents()
        configureLayout()
        
    }
    
    var micellar = newStepUIView()
    var eyeCream = newStepUIView()
    var toner = newStepUIView()
    var cleanser = newStepUIView()
    var serum = newStepUIView()
    var moisturizer = newStepUIView()
    var acneCare = newStepUIView()
    var exfoliator = newStepUIView()
    
    override func configureComponents() {
        mainStackView.addArrangedSubview(micellar)
        micellar.titleLabel.text = "Micellar water"
        
        mainStackView.addArrangedSubview(eyeCream)
        eyeCream.titleLabel.text = "Eye cream"
        
        mainStackView.addArrangedSubview(toner)
        toner.titleLabel.text = "Toner"
        
        mainStackView.addArrangedSubview(cleanser)
        cleanser.titleLabel.text = "Cleanser"
        
        mainStackView.addArrangedSubview(serum)
        serum.titleLabel.text = "Serum"
        
        mainStackView.addArrangedSubview(moisturizer)
        moisturizer.titleLabel.text = "Moisturizer"
        
        mainStackView.addArrangedSubview(acneCare)
        acneCare.titleLabel.text = "Acne care"
        
        mainStackView.addArrangedSubview(exfoliator)
        exfoliator.titleLabel.text = "Exfoliator"
    }
    
    override func configureLayout() {
        view.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        micellar.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        eyeCream.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        toner.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        serum.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        cleanser.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        moisturizer.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        acneCare.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        exfoliator.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }

}
