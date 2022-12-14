//
//  NightRoutinesViewController.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 11/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

@available(iOS 16.0, *)
class NightRoutinesViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource{

    var products: [Product] = [Product]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NightRoutineStepsTableViewCell", for: indexPath) as! NightRoutinesStepsTableViewCell
        let currentLastItem = products[indexPath.row]
        cell.product = currentLastItem
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        if tableView.isEditing == true {
            cell.imageRight.isHidden = true
        } else {
            cell.imageRight.isHidden = false
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        self.tableView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        navBar()
        ConfigureUI()
    }
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(NightRoutinesStepsTableViewCell.self, forCellReuseIdentifier: "NightRoutineStepsTableViewCell")
        return tv
    }()
    
    func bindTableData() {
     
        products.append(Product(titleLabel: "Toner", numLabel: "1", imageRight: UIImage(systemName: "chevron.right")!))
        products.append(Product(titleLabel: "Cleanser", numLabel: "2", imageRight: UIImage(systemName: "chevron.right")!))
        products.append(Product(titleLabel: "Serum", numLabel: "3", imageRight: UIImage(systemName: "chevron.right")!))
        products.append(Product(titleLabel: "Moisturizer", numLabel: "4", imageRight: UIImage(systemName: "chevron.right")!))
        products.append(Product(titleLabel: "Sunscreen", numLabel: "5", imageRight: UIImage(systemName: "chevron.right")!))
        products.append(Product(titleLabel: "Eye cream", numLabel: "6", imageRight: UIImage(systemName: "chevron.right")!))
        products.append(Product(titleLabel: "Acne care", numLabel: "7", imageRight: UIImage(systemName: "chevron.right")!))
        products.append(Product(titleLabel: "Exfoliator", numLabel: "8", imageRight: UIImage(systemName: "chevron.right")!))
    }

    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    func navBar() {
        let button = UIButton(type: .custom)
        //Set the image
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        //Set the title
        button.setTitle(" ", for: .normal)
        //Add target
        button.addTarget(self, action: #selector(goToHomeRoutine), for: .touchUpInside)
        button.tintColor = .white
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        button.sizeToFit()
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func goToHomeRoutine() {
        let controller = RoutineHomeViewController()
        navigationController?.popViewController(animated: true)
    }
    
    let navbar: UIView = {
        let nav = UIView()
        return nav
    }()
    
    private lazy var hStackViewHeader: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private let routineSteps: UILabel = {
        let label = UILabel()
        label.text = "Routine steps"
        label.font = .clashGroteskMedium(size: 22)
        label.textColor = .black
        return label
    }()
    
    private let editBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .clashGroteskMedium(size: 13)
        button.setTitle("Edit steps", for: .normal)
        button.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        button.layer.cornerRadius = 14.0
        return button
    }()
    
    private let addBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .clashGroteskMedium(size: 18)
        button.setTitle("+ Add new step", for: .normal)
        button.layer.cornerRadius = 8.0
        button.layer.borderWidth = 1.0
        return button
    }()
    
    private let finishBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .clashGroteskMedium(size: 18 )
        button.setTitle("Finish routine", for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .black
        return button
    }()
    
    private lazy var stepsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    override func configureComponents() {
        navbar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 252)
        navbar.applyGradient(colours: [UIColor(red: 45/255, green: 61/255, blue: 119/255, alpha: 1), UIColor(red: 11/255, green: 28/255, blue: 87/255, alpha: 1)], locations: [0, 1], radius: 0)
        
        navbar.addSubview(sunIcon)
        navbar.addSubview(titleMorning)
        mainStackView.addArrangedSubview(navbar)
        
        hStackViewHeader.addArrangedSubview(routineSteps)
        hStackViewHeader.addArrangedSubview(editBtn)
        editBtn.addTarget(self, action: #selector(editMenu), for: .touchUpInside)
        mainStackView.addArrangedSubview(hStackViewHeader)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        mainStackView.addArrangedSubview(tableView)
        mainStackView.addArrangedSubview(addBtn)
        addBtn.addTarget(self, action: #selector(goToAddNewPage), for: .touchUpInside)
        mainStackView.addArrangedSubview(finishBtn)
        tableView.reloadData()
    }
    
    @objc func goToAddNewPage() {
        let controller = AddNewStepUIViewController()
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: false)
    }
    
    @objc func editMenu() {
        tableView.isEditing = !tableView.isEditing
        let title = (tableView.isEditing) ? "Done" : "Edit steps"
        editBtn.setTitle(title, for: .normal)
        
        if tableView.isEditing == true {
            finishBtn.isEnabled = false
            finishBtn.layer.backgroundColor = CGColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
            finishBtn.setTitleColor(UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 125/255), for: .normal)
            tableView.reloadData()
        }else {
            finishBtn.isEnabled = true
            finishBtn.layer.backgroundColor = UIColor.black.cgColor
            finishBtn.setTitleColor(.white, for: .normal)
            tableView.reloadData()
        }
        
    }
    
    // method to run when table view cell is tapped
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           // note that indexPath.section is used rather than indexPath.row
           print("You tapped cell number \(indexPath.row).")
       }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.products[sourceIndexPath.row]
        products.remove(at: sourceIndexPath.row)
        products.insert(movedObject, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            products.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.deleteSections([indexPath.section], with: .fade)
        }
    }
    
    let cellSpacingHeight: CGFloat = 0
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
         return headerView
     }
    
    override func configureLayout() {
        view.addSubview(mainStackView)
        
        hStackViewHeader.snp.makeConstraints { make in
            make.top.equalTo(navbar.snp.bottom).offset(20)
        }
        
        mainStackView.snp.makeConstraints { make in
           make.top.right.bottom.left.equalToSuperview()
       }
        
        navbar.snp.makeConstraints { (make) -> Void in
            make.top.width.equalToSuperview()
            make.height.equalTo(252)
        }
        
        sunIcon.snp.makeConstraints { make in
            make.height.width.equalTo(64)
            make.centerX.equalTo(view.center.x)
            make.centerY.equalTo(126)
        }
        
        titleMorning.snp.makeConstraints { make in
            make.centerX.equalTo(view.center.x)
            make.top.equalTo(sunIcon.snp.bottom).offset(15)
        }
        
        routineSteps.snp.makeConstraints { make in
            make.top.equalTo(navbar.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        editBtn.snp.makeConstraints { make in
            make.width.equalTo(82)
            make.height.equalTo(28)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        addBtn.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.top.equalTo(tableView.snp.bottom).offset(20)
            make.bottom.equalTo(finishBtn.snp.top).offset(-55)
        }
        
        finishBtn.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-8)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(hStackViewHeader.snp.bottom).offset(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
    }
    
    private let sunIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "wb_sunny")
        return image
    }()
    
    private let titleMorning: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.text = "Night routine"
        title.font = .clashGroteskMedium(size: 30)
        return title
    }()
    
    func ConfigureUI() {
        bindTableData()
        configureComponents()
        configureLayout()
    }
    

}
