//
//  ResultProblemView.swift
//  Quint
//
//  Created by Vendly on 17/10/22.
//

import UIKit
import SnapKit
import SwiftUI
import CoreData

class ResultProblemView: UIView {
    
    private var problemList: [ProblemModel] = []
    private let titleLabel = TitleLabel()
    private let resultLabel = ResultLabel()
    private var descriptionLabel = DescriptionLabel()
    private let backgroundImage = UIImageView()
    var textHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureComponents() {
        
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 36
        self.layer.shadowOffset = CGSize(width: 0, height: 16)
        self.layer.shadowColor = K.Color.shadowQuint.cgColor
        self.layer.cornerRadius = 10
        
//        backgroundImage.image = UIImage(named: "warning_logo")
//        backgroundImage.layer.compositingFilter = "overlayBlendMode"
//        backgroundImage.sizeToFit()
        
        titleLabel.text = "SKIN PROBLEM"
        titleLabel.sizeToFit()
        titleLabel.textColor = K.Color.redSkinProblemQuint
        
        descriptionLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 88, height: 0)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
    }
    
    override func configureLayout() {
        
        multipleSubviews(view: titleLabel,
                               resultLabel,
                               descriptionLabel)
        
//        backgroundImage.snp.makeConstraints { make in
//            make.leading.equalTo(148)
//            make.top.equalTo(-56)
//        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(28)
            make.width.equalToSuperview().offset(-48)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(0)
            make.width.equalToSuperview().offset(-48)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
            make.height.equalTo(0)
            make.top.equalTo(resultLabel.snp.bottom).offset(10)
        }
        
    }
    
    func setProblems(problemIds: [Int]){
        problemList = fetchProblems(problemIds: problemIds)
        
        resultLabel.text = generateResultTitle()
        resultLabel.sizeToFit()
        descriptionLabel.attributedText = generateDesc()
        descriptionLabel.sizeToFit()
        
        descriptionLabel.snp.updateConstraints { make in
            make.height.equalTo(descriptionLabel.requiredHeight)
        }
        
        resultLabel.snp.updateConstraints { make in
            make.height.equalTo(resultLabel.requiredHeight)
        }
        
        print(titleLabel.requiredHeight)
        print(descriptionLabel.requiredHeight)
        print(resultLabel.requiredHeight)
        
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 56+titleLabel.requiredHeight+descriptionLabel.requiredHeight+resultLabel.requiredHeight+18)
        
        self.applyGradient(colours: [K.Color.redLightQuint, K.Color.redQuint], locations: [0,1], radius: 8)
    }
    
    func generateResultTitle() -> String{
        var titleString = ""
        for i in 0..<problemList.count{
            if (i == 0){
                titleString += problemList[i].title!.firstUppercased
            }
            else{
                titleString += problemList[i].title!.lowercased()
            }
            
            if(i != problemList.count-1){
                titleString += ", "
            }
        }
        
        return titleString
    }
    
    func generateDesc() -> NSMutableAttributedString{
        let desc = NSMutableAttributedString(string: "")
        problemList.forEach { problem in
            desc.append(NSMutableAttributedString(string: "\u{2022} \(problem.title!): ", attributes: [NSAttributedString.Key.font : UIFont.interSemiBold(size: 14)! ]))
            
            desc.append(NSMutableAttributedString(string: problem.desc!, attributes: [NSAttributedString.Key.font : UIFont.interRegular(size: 14)! ]))
                        
            if(problem != problemList.last){
                desc.append(NSAttributedString(string: "\n\n"))
            }
        }
    
        return desc
    }
    
    public func fetchProblems(problemIds: [Int]) -> [ProblemModel]{
            
        var problemList: [ProblemModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Problems")
        
        var predicateList: [NSPredicate] = []
        problemIds.forEach { id in
            let idPredicate = NSPredicate(format: "id == %@", String(describing:id+1))
            predicateList.append(idPredicate)
        }
        let compoundPredicate = NSCompoundPredicate(type: .or, subpredicates: predicateList)
        
        request.predicate = compoundPredicate
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            
            for result in results {
                let problem = result as? ProblemModel
                problemList.append(problem!)
            }
            
            return problemList
        }
        catch{
            print("fetch failed")
        }
        
        return problemList
    }    
}
