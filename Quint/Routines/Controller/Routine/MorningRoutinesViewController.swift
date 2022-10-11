//
//  MorningRoutinesViewController.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 10/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

@available(iOS 16.0, *)
class MorningRoutinesViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        navBar()
        ConfigureUI()
    }
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(MorningRoutineStepsTableViewCell.self, forCellReuseIdentifier: "MorningRoutineStepsTableViewCell")
        tv.sectionHeaderHeight = 12
        tv.sectionFooterHeight = 0
        return tv
    }()
    
    
    
    func bindTableData() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Product>> { _, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "MorningRoutineStepsTableViewCell", for: indexPath) as! MorningRoutineStepsTableViewCell
            cell.product = item
            return cell
        } titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }

        self.viewModel.items.bind(to: self.tableView.rx.items(dataSource: dataSource)).disposed(by: bag)
        
        //Fetch items
        viewModel.fetchItems()
    }
    
    private var viewModel = RoutineSteps()
    private var bag = DisposeBag()
    
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
        nav.backgroundColor = UIColor(red: 242/255, green: 105/255, blue: 6/255, alpha: 1)
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
        label.font = label.font.withSize(22)
        label.textColor = .black
        return label
    }()
    
    private let editBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1), for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(13)
        button.setTitle("Edit steps", for: .normal)
        button.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        button.layer.cornerRadius = 14.0
        return button
    }()
    
    private let addBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1), for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(13)
        button.setTitle("+ Add new step", for: .normal)
        button.layer.cornerRadius = 8.0
        button.layer.borderWidth = 1.0
        return button
    }()
    
    private let finishBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(13)
        button.setTitle("Finish routine", for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .black
        return button
    }()
    
    override func configureComponents() {
        navbar.addSubview(sunIcon)
        navbar.addSubview(titleMorning)
        mainStackView.addArrangedSubview(navbar)
        
        hStackViewHeader.addArrangedSubview(routineSteps)
        hStackViewHeader.addArrangedSubview(editBtn)
        editBtn.addTarget(self, action: #selector(editMenu), for: .touchUpInside)
        mainStackView.addArrangedSubview(hStackViewHeader)
        
        mainStackView.addArrangedSubview(tableView)
        mainStackView.addArrangedSubview(addBtn)
        mainStackView.addArrangedSubview(finishBtn)
        
        
    }
    
    @objc func editMenu() {
        tableView.isEditing = !tableView.isEditing
        let title = (tableView.isEditing) ? "Done" : "Edit steps"
        editBtn.setTitle(title, for: .normal)
    }

    
    override func configureLayout() {
        view.addSubview(mainStackView)
        
        navbar.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.topLayoutGuide.snp.top)
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
            make.top.equalTo(hStackViewHeader.snp.bottom)
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
        title.text = "Morning routine"
        title.font = title.font.withSize(30)
        return title
    }()
    
    func ConfigureUI() {
        bindTableData()
        configureComponents()
        configureLayout()
    }


}
