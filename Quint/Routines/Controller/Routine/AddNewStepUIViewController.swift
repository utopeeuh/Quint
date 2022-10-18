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
    
    private var crossButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        return button
    }()
    
    private lazy var hStackViewHeader: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var vStackViewTitle: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add new step"
        label.textColor = .black
        label.font = label.font.withSize(16)
        return label
    }()
    
    private var imageHeader: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "handle")
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.title = "Add new step"
        ConfigureUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
        setupPanGesture()
    }
    
    
    @objc func goToMorningRoutine() {
        animateDismissView()
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
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    override func configureComponents() {
        
        vStackViewTitle.addArrangedSubview(imageHeader)
        vStackViewTitle.addArrangedSubview(titleLabel)
        
        hStackViewHeader.addArrangedSubview(crossButton)
        hStackViewHeader.addArrangedSubview(vStackViewTitle)
        containerView.addSubview(hStackViewHeader)
        mainStackView.addArrangedSubview(lineView)
        
        mainStackView.addArrangedSubview(micellar)
        micellar.titleLabel.text = "Micellar water"
        
        mainStackView.addArrangedSubview(eyeCream)
        eyeCream.titleLabel.text = "Eye cream"
        
        mainStackView.addArrangedSubview(toner)
        toner.titleLabel.text = "Toner"
        
        //Add target
        crossButton.addTarget(self, action: #selector(goToMorningRoutine), for: .touchUpInside)
 
    }
    
    override func configureLayout() {
        setupConstraints()
        
        mainStackView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaInsets).offset(20)
            make.right.equalTo(view.safeAreaInsets).offset(-20)
            make.top.equalTo(hStackViewHeader.snp.bottom)
            make.bottom.equalTo(view.safeAreaInsets).offset(-20)
        }
        
        containerView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        dimmedView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        micellar.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        eyeCream.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        toner.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        hStackViewHeader.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets).offset(20)
            make.height.equalTo(50)
        }
        
        crossButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.equalTo(view.safeAreaInsets).offset(15)
            make.left.equalTo(view.safeAreaInsets).offset(20)
        }
        
        imageHeader.snp.makeConstraints { make in
            make.height.equalTo(4)
            make.width.equalTo(40)
            make.top.equalToSuperview().offset(-20)
            make.left.equalTo(crossButton.snp.left).offset(view.frame.width / 2 - 35)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        
    }
    
    func setupConstraints() {
        // Add subviews
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
       
        
        // Set dynamic constraints
        // First, set container to default height
        // after panning, the height can expand
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        // By setting the height to default height, the container will be hide below the bottom anchor view
        // Later, will bring it up by set it to 0
        // set the constant to default height to bring it down again
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        // Activate constraints
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
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
    
    func setupView() {
        view.backgroundColor = .clear
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
