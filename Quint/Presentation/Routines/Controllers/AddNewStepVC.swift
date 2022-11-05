//
//  AddNewStepUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 17/10/22.
//

import UIKit
import SnapKit

@available(iOS 16.0, *)
class AddNewStepVC: UIViewController {
    
    private var unaddedSteps : [CategoryModel] = []
    var routineTime : K.RoutineTime?
    var delegate: AddNewStepDelegate?
    
    private var crossButton = UIButton()
    private var titleLabel = UILabel()
    private var handleBar = UIImageView()
    private var seperator = UIView()
    
    private var productStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupPanGesture()
    }
    
    override func configureComponents() {
        
        crossButton.setImage(UIImage(named:"CrossIcon"), for: .normal)
        
        crossButton.addTarget(self, action: #selector(handleCloseAction), for: .touchUpInside)
        
        titleLabel.text = "Add new step"
        titleLabel.textColor = .black
        titleLabel.font = .interMedium(size: 16)
        
        handleBar.image = UIImage(named: "handle")
        
        seperator.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        productStack.axis = .vertical
        productStack.distribution = .fill
        productStack.spacing = 0

        unaddedSteps = CategoriesRepository.shared.fetchUnaddedRoutineCategories(time: routineTime!)
        unaddedSteps.forEach { category in
            let newCell = NewStepUIView()
            newCell.setCategory(category: category)
            //add target here
            let tap = AddStepGestureRecognizer(target: self, action: #selector(cellOnClick))
            tap.categoryId = newCell.categoryId!
            newCell.addGestureRecognizer(tap)
            
            productStack.addArrangedSubview(newCell)
        }
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureLayout() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        
        //
        containerView.multipleSubviews(view: crossButton, titleLabel, handleBar, seperator, productStack)
        
        crossButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.left.equalToSuperview().offset(16)
        }
        
        handleBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(handleBar.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
        }
        
        seperator.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.width.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        productStack.subviews.forEach { view in
            if let cell = view as? NewStepUIView{
                cell.snp.makeConstraints { make in
                    make.height.equalTo(cell.height)
                }
            }
        }
        
        productStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(NewStepUIView().height * productStack.subviews.count)
            make.top.equalTo(seperator.snp.bottom)
        }
        //
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        // Activate constraints
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
        
        containerView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        dimmedView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    @objc func cellOnClick(sender: AddStepGestureRecognizer){
        print("yo")
        // 10 - unaddedSteps.count
        let newStepCategory = CategoriesRepository.shared.fetchCategory(id: Int(truncating: sender.categoryId))
        let isMorning = routineTime == .morning ? true : false
    
        StepsRepository.shared.createRoutineStep(category: newStepCategory, isMorning: isMorning, position: (10-unaddedSteps.count))
        animateDismissView()
        delegate?.addedNewStep()
    }
    
    //MARK: - TEMPLATE
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    @objc func handleCloseAction() {
        animateDismissView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    let maxDimmedAlpha: CGFloat = 0.6
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    // Constants
    let defaultHeight: CGFloat = 400
    let dismissibleHeight: CGFloat = 300
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    // keep current new height, initial is default height
    var currentContainerHeight: CGFloat = 400
    // Dynamic container constraint
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    func setupPanGesture() {
        // add pan gesture recognizer to the view controller's view (the whole screen)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        // change to false to immediately listen on gesture movement
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    // MARK: Pan gesture handler
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        // Drag to top will be minus value and vice versa
        print("Pan gesture y offset: \(translation.y)")
        
        // Get drag direction
        let isDraggingDown = translation.y > 0
        print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
        
        // New height is based on value of dragging plus current container height
        let newHeight = currentContainerHeight - translation.y
        
        // Handle based on gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            if newHeight < maximumContainerHeight {
                // Keep updating the height constraint
                containerViewHeightConstraint?.constant = newHeight
                // refresh layout
                view.layoutIfNeeded()
            }
        case .ended:
            // This happens when user stop drag,
            // so we will get the last height of container
            
            // Condition 1: If new height is below min, dismiss controller
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            }
            else if newHeight < defaultHeight {
                // Condition 2: If new height is below default, animate back to default
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                // Condition 3: If new height is below max and going down, set to default height
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                // Condition 4: If new height is below max and going up, set to max height at top
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            // Update container height
            self.containerViewHeightConstraint?.constant = height
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
        // Save current height
        currentContainerHeight = height
    }
    
    // MARK: Present and dismiss animation
    func animatePresentContainer() {
        // update bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    func animateDismissView() {
        // hide blur view
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            // once done, dismiss without animation
            self.dismiss(animated: false)
        }
        // hide main view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }

}
