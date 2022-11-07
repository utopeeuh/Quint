//
//  RoutineDetailVC.swift
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
class RoutineDetailVC: UIViewController{
    
    var routineTime : K.RoutineTime?
    var routineSteps: [RoutineStepInfo] = []
    
    private var mainScrollView = UIScrollView()
    
    private var backBtn = UIButton(type: .custom)
    
    private var heroBg = UIView()
    private var heroIcon = UIImageView()
    private var mainTitle = UILabel()
    
    private var tableView = UITableView()
    
    private var routineStepsLbl = HeaderLabel()
    private var editBtn = UIButton()
    private var bottomBtn = UIButton()
    
    private var subViews : [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        overrideUserInterfaceStyle = .dark
        configureUI()
    }
    
    override func configureComponents() {
        
        view.backgroundColor = K.Color.bgQuint
        view.isUserInteractionEnabled = true
        
        //set data
        routineSteps = StepsRepository.shared.fetchRoutineSteps(time: routineTime!)
        
        //hero bg
        var heroGradientColors : [UIColor] = []
        heroGradientColors = [K.Color.orangeLightQuint, K.Color.orangeQuint]
        
        //hero icon
        heroIcon = UIImageView(image: UIImage(named: "MorningHeroIcon"))
        
        //main title
        mainTitle.text = "Morning routine"
        mainTitle.font = .clashGroteskMedium(size: 30)
        
        if(routineTime == .night){
            mainTitle.text = "Night routine"
            heroIcon = UIImageView(image: UIImage(named: "NightHeroIcon"))
            heroGradientColors = [UIColor(red: 45/255, green: 61/255, blue: 119/255, alpha: 1), UIColor(red: 11/255, green: 28/255, blue: 87/255, alpha: 1)]
        }
        
        heroBg.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 252)
        heroBg.applyGradient(colours: heroGradientColors, locations: [0, 1], radius: 0)

        //back button
//        backBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        backBtn.setImage(UIImage(named: "ChevronLeft"), for: .normal)
        backBtn.setTitle(" ", for: .normal)
        backBtn.tintColor = .white
        backBtn.sizeToFit()
        backBtn.addTarget(self, action: #selector(goToHomeRoutine), for: .touchUpInside)
        
        //table view
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RoutineDetailStepCell.self, forCellReuseIdentifier: "RoutineDetailStepCell")
        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.reloadData()
        
        //routineStepsLbl
        routineStepsLbl.text = "Routine steps"
        routineStepsLbl.font = .clashGroteskMedium(size: 22)
        routineStepsLbl.textColor = .black
        
        //edit button
        editBtn.setTitleColor(UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1), for: .normal)
        editBtn.titleLabel?.font = .clashGroteskMedium(size: 13)
        editBtn.setTitle("Edit steps", for: .normal)
        editBtn.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        editBtn.layer.cornerRadius = 14.0
        editBtn.addTarget(self, action: #selector(editMenu), for: .touchUpInside)
        
        //finish button
        bottomBtn.setTitleColor(.white, for: .normal)
        bottomBtn.titleLabel?.font = .clashGroteskMedium(size: 18 )
        bottomBtn.setTitle("Finish routine", for: .normal)
        bottomBtn.layer.cornerRadius = 8.0
        bottomBtn.backgroundColor = .black
        bottomBtn.addTarget(self, action: #selector(bottomButtonOnClick), for: .touchUpInside)
    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: heroBg,
                              heroIcon,
                              mainTitle,
                              backBtn,
                              tableView,
                              routineStepsLbl,
                              editBtn,
                              bottomBtn)
        
        heroBg.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.right.equalToSuperview()
            make.height.equalTo(252)
        }
        
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(24)
        }
        
        heroIcon.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(64)
        }
        
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(heroIcon.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
        }
        
        routineStepsLbl.snp.makeConstraints { make in
            make.top.equalTo(heroBg.snp.bottom).offset(28)
            make.left.equalToSuperview().offset(20)
        }
        
        editBtn.snp.makeConstraints { make in
            make.top.equalTo(heroBg.snp.bottom).offset(28)
            make.right.equalTo(view).offset(-20)
            make.width.equalTo(82)
            make.height.equalTo(28)
        }
        
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.top.equalTo(routineStepsLbl.snp.bottom).offset(24)
            make.bottom.equalTo(bottomBtn.snp.top).offset(-20)
        }
        
        bottomBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    @objc func bottomButtonOnClick(){
        if tableView.isEditing{
            goToAddNewPage()
        } else {
            finishRoutine()
        }
    }
    
    @objc func goToHomeRoutine() {
        navigationController?.popViewController(animated: true)
    }
    
    func finishRoutine(){
        
    }
    
    func goToAddNewPage() {
        let controller = AddNewStepVC()
        controller.routineTime = self.routineTime
        controller.delegate = self
        
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: false)
    }
    
    @objc func editMenu() {
        tableView.isEditing = !tableView.isEditing
        
        UIView.animate(withDuration: 0.4, animations: { [self] in
            if(tableView.isEditing){
                editBtn.setTitle("Done", for: .normal)
                editBtn.backgroundColor = .black
                editBtn.setTitleColor(.white, for: .normal)
                editBtn.snp.updateConstraints { make in
                    make.width.equalTo(53)
                }
                
                bottomBtn.setTitle("+ Add new step", for: .normal)
            }
            else{
                editBtn.setTitle("Edit steps", for: .normal)
                editBtn.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
                editBtn.setTitleColor(.black, for: .normal)
                editBtn.snp.updateConstraints { make in
                    make.width.equalTo(82)
                }
                
                bottomBtn.setTitle("Finish routine", for: .normal)
                
                //update steps here lempar routine steps
                StepsRepository.shared.updateRoutineSteps(steps: routineSteps, time: routineTime!)
            }
            
        })
        tableView.reloadData()
    }
}

@available(iOS 16.0, *)
extension RoutineDetailVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutineDetailStepCell", for: indexPath) as! RoutineDetailStepCell
        let currentLastItem = routineSteps[indexPath.row]
        cell.setCellInfo(title: currentLastItem.title, position: currentLastItem.position)
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.selectionStyle = .none
        routineTime == .morning ? cell.setMorningCell() : cell.setNightCell()
        cell.trashBtn.addTarget(self, action: #selector(deleteStep), for: .touchUpInside)
       
        if tableView.isEditing == true {
            cell.setEditingOn()
        } else {
            cell.setEditingOff()
            
            //re-number steps
            for i in 0..<routineSteps.count{
                if(cell.titleLabel.text == routineSteps[i].title){
                    cell.numLabel.text = String(describing: i+1)
                    routineSteps[i].position = i+1
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routineSteps.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.routineSteps[sourceIndexPath.row]
        routineSteps.remove(at: sourceIndexPath.row)
        routineSteps.insert(movedObject, at: destinationIndexPath.row)
    }
    
    @objc func deleteStep(_ sender: RoutineCellTrashButton){
        for i in 0..<routineSteps.count{
            if sender.cellTitle == routineSteps[i].title{
                let alert = UIAlertController(title: "Remove step?", message: nil, preferredStyle: .actionSheet)

                alert.addAction(UIAlertAction(title: "Remove", style: .destructive , handler:{ [self] (UIAlertAction) in
                    
                    // remove from core data
                    StepsRepository.shared.deleteRoutineStep(step: routineSteps[i], time: routineTime!)
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

                self.present(alert, animated: true, completion: {
                    print("completion block")
                })
                
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
            return false
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

@available(iOS 16.0, *)
extension RoutineDetailVC : AddNewStepDelegate {
    func addedNewStep() {
        routineSteps = StepsRepository.shared.fetchRoutineSteps(time: routineTime!)
        tableView.reloadData()
        print("Reloaded data")
    }
}
