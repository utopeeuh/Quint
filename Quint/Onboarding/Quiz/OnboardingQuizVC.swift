//
//  QuizSkinTypeVC.swift
//  Quint
//
//  Created by Vendly on 05/10/22.
//

import UIKit
import SnapKit

class OnboardingQuizVC: UIViewController, PhotoConfirmationVCDelegate {
    
    func didTapConfirmButton() {
        
        nextOnClick()
        photoConfirmationVC.dismiss(animated: true)
        
    }
    
    func didTapCancelButton() {
        
        photoConfirmationVC.dismiss(animated: true)
        self.didTapPhoto()
        
    }
    
    @objc func didTapPhoto() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.cameraDevice = .front
        picker.delegate = self
        picker.cameraFlashMode = .off
        present(picker, animated: true)
        moveToCurrIndex()
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

    private var photoConfirmationVC = PhotoConfirmationVC()
    private var backButton = BackButton()
    private var progressBar = UIProgressView()
    private var scrollView = UIScrollView()
    
    // page indexing as follows
    private var childContents: [UIView] = [
        SkinTypeView(),
        SkinConditionView(),
        SkinProblemView(),
        SkinLogView(),
        SkinNotifView(),
        SkinInsightView()
    ]
    
    private var currIndex = 0
    private var multiplier: CGFloat = 0
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = K.Color.bgQuint
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moveToCurrIndex()
    }
    
    override func configureComponents() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        backButton.addTarget(self, action: #selector(backOnClick), for: .touchUpInside)
        
        for child in childContents
        {
            if let view = child as? SkinLogView
            {
                view.takePhotoButton.addTarget(self, action: #selector(didTapPhoto), for: .touchUpInside)
            }
        }
        
        scrollView.backgroundColor = K.Color.bgQuint
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width*2, height: UIScreen.main.bounds.height)
        scrollView.isScrollEnabled = false
        
        progressBar.setProgress(1/6, animated: true)
        progressBar.trackTintColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        progressBar.progressTintColor = K.Color.greenButtonQuint
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
            
            v.setVC(self)
            v.snp.makeConstraints { make in
                
                make.width.equalToSuperview()
                make.top.equalTo(scrollView)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide)
                
                let isFirstPage = i == 0
                let isLastPage  = i == childContents.count - 1
                
                if isFirstPage      { make.leading.equalToSuperview() }
                else if isLastPage  { make.trailing.equalToSuperview() }
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
    
    func nextOnClick(){
        currIndex += 1
        moveToCurrIndex()
        progressBar.setProgress((1/6) * Float(currIndex+1), animated: true)
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
    
    func moveToCurrIndex(){
        scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width * CGFloat(currIndex), y: 0), animated: true)
    }
        
    func allowNotif() {

        let controller = OnboardingQuizVC()

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

            

        }


    }
    
}

extension OnboardingQuizVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker:UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        moveToCurrIndex()
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                                didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey :Any]) {
        
        let image = info[.originalImage] as? UIImage
    
        picker.dismiss(animated: false, completion: nil)
        didConfirmPhoto(image)
    }
    
}
