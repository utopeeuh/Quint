//
//  QuizSkinTypeVC.swift
//  Quint
//
//  Created by Vendly on 05/10/22.
//

import UIKit
import SnapKit
import AVFoundation

@available(iOS 16.0, *)
class OnboardingQuizVC: UIViewController, PhotoConfirmationVCDelegate {
    
    var data = OnboardingData()
    
    lazy var notifView = SkinNotifView()
    private var photoConfirmationVC = PhotoConfirmationVC()
    private var backButton = BackButton()
    private var progressBar = UIProgressView()
    private var scrollView = UIScrollView()
    
    // page indexing as follows
    private lazy var childContents: [UIView] = [
        SkinTypeView(),
        SkinConditionView(),
        SkinProblemView(),
        SkinLogView(),
        notifView,
        SkinInsightView()
    ]
    
    private var currIndex = 0
    private var multiplier: CGFloat = 0
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moveToCurrIndex()
    }
    
    override func configureComponents() {
        
        view.backgroundColor = K.Color.bgQuint
        notifView.delegate = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        backButton.addTarget(self, action: #selector(backOnClick), for: .touchUpInside)
        
        for child in childContents
        {
            if let view = child as? SkinLogView {
                view.takePhotoButton.addTarget(self, action: #selector(didTapPhoto), for: .touchUpInside)
            }
            
            if let view = child as? SkinInsightView {
                view.insightsButton.addTarget(self, action: #selector(goToOnboardingResult), for: .touchUpInside)
            }
        }
        
        scrollView.backgroundColor = K.Color.bgQuint
        scrollView.isScrollEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width*CGFloat(childContents.count), height: UIScreen.main.bounds.height)
        
        progressBar.setProgress(1/6, animated: true)
        progressBar.trackTintColor = K.Color.disableBgBtnQuint
        progressBar.progressTintColor = K.Color.greenQuint
        progressBar.layer.cornerRadius = 4
        progressBar.clipsToBounds = true
    }
    
    override func configureLayout() {
    
        view.multipleSubviews(view:
                                backButton,
                                progressBar,
                                scrollView)
        
        // layouting child view content
        childContents.forEach {
            scrollView.addSubview($0)
        }
        
        var prev: UIView?
        for i in 0..<childContents.count {
            guard let v = childContents[i] as? OnboardingParentView
            else { return }
            
            v.setQuizVC(self)
            v.snp.makeConstraints { make in
                
                make.width.equalToSuperview()
                make.top.equalTo(scrollView)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide)
                
                let isFirstPage = i == 0
                
                if isFirstPage      { make.leading.equalToSuperview() }
                else                { make.leading.equalTo(prev!.snp.trailing) }
                
                prev = v
            }
            multiplier += 1
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(20)
        }
        
        progressBar.snp.makeConstraints { make in
            make.height.equalTo(7)
            make.top.equalTo(backButton).offset(7)
            make.left.equalTo(backButton.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(46)
            make.bottom.equalTo(view)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
    }
    
    func moveToCurrIndex(){
        scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width * CGFloat(currIndex), y: 0), animated: true)
    }
    
    func nextOnClick(){
        
        switch(childContents[currIndex]){
        case is SkinTypeView:
            data.selectedSkinType = (childContents[currIndex] as! SkinTypeView).getSkinType()
            print(data.selectedSkinType!)
            break
        case is SkinConditionView:
            data.isSensitive = (childContents[currIndex] as! SkinConditionView).isSensitive()
            print(data.isSensitive!)
            break
        case is SkinProblemView:
            data.skinProblems = (childContents[currIndex] as! SkinProblemView).getSelectedProblems()
            print(data.skinProblems!)
            
            data.routineCategoryList = K.defaultRoutineOnboarding
            
            var eyeCareFlag = false
            var acneCareFlag = false
            for i in 0..<data.skinProblems!.count{
                if(data.skinProblems![i]+1 == K.Problem.darkCircles){
                    print("has dark circles")
                    eyeCareFlag = true
                } else if (data.skinProblems![i]+1 == K.Problem.acne){
                    print("has acne")
                    acneCareFlag = true
                }
            }
            
            if !eyeCareFlag {
                data.routineCategoryList.removeAll { $0 == K.ProductCategory.eyeCare }
            }
            if !acneCareFlag {
                data.routineCategoryList.removeAll { $0 == K.ProductCategory.acneCare }
            }
            
            print(data.routineCategoryList)
            
            break
        default:
            break
        }
        currIndex += 1
        moveToCurrIndex()
        progressBar.setProgress((1/6) * Float(currIndex+1), animated: true)
    }
    
    func didTapConfirmButton() {
        nextOnClick()
        data.chosenImage = photoConfirmationVC.chosenImage
        photoConfirmationVC.dismiss(animated: true)
    }
    
    func didTapCancelButton() {
        photoConfirmationVC.dismiss(animated: true)
    }
    
    // from uiimagepicker delegate
    func didConfirmPhoto(_ image: UIImage?) {
        
        let vc = photoConfirmationVC
        vc.chosenImage = image
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        moveToCurrIndex()
    }
    
    @objc func didTapPhoto() {
        // If camera permission is allowed OR not determined
        let cameraPerms = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if  cameraPerms == .authorized || cameraPerms == .notDetermined {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.cameraDevice = .front
            picker.delegate = self
            picker.cameraFlashMode = .off
            present(picker, animated: true)
            moveToCurrIndex()
        }
        else{
            //Present alert - prompt to enable
            let alert = UIAlertController.rejectedCameraAlert()
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc func backOnClick(){
        if currIndex == 0 {
            self.navigationController?.popViewController(animated: true)
        }
        else{
            currIndex -= 1
            moveToCurrIndex()
            progressBar.setProgress((1/6) * Float(currIndex+1), animated: true)
        }
    }
    
    @objc func goToOnboardingResult() {
        // pass data to onboarding result
        let vc = OnboardingResultVC()
        vc.data = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

@available(iOS 16.0, *)
extension OnboardingQuizVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker:UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        moveToCurrIndex()
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                                didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey :Any]) {
        
        let image = info[.originalImage] as? UIImage
        
        // If camera permission is allowed
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
            picker.dismiss(animated: false, completion: nil)
            didConfirmPhoto(image)
        } else{
            // If permission rejected
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
}

@available(iOS 16.0, *)
extension OnboardingQuizVC: AllowNotificationDelegate {
    
    func allowNotif() {

        let group = DispatchGroup()
        group.enter()

        var isNotificationsEnabled = false

        DispatchQueue.main.async {
           let center = UNUserNotificationCenter.current()

           center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in

               if error != nil {
                   print("notification disabled!")
               }

               if granted {
                   isNotificationsEnabled = true

               } else {
                   isNotificationsEnabled = false
               }

               group.leave()

           }

        }

        group.notify(queue: .main) {

            self.nextOnClick()

        }


    }
    
}
