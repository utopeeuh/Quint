//
//  ProfileVC.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 31/10/22.
//

import UIKit

class ProfileVC: UIViewController {
    
    var headerProfile = HeaderProfileUIView()
    var reminderNotification = SettingsUIView()
    var deleteAcc = SettingsUIView()
    var skinType = AboutMySkinUIView()
    var skinProblem = AboutMySkinUIView()
    var sensitiveSkin = AboutMySkinUIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.Color.bgQuint
        configureUI()
    }
    
    private let mainScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var aboutMySkinLabel: UILabel = {
        let label = UILabel()
        label.font = .clashGroteskMedium(size: 20)
        label.text = "About My Skin"
        label.textColor = .black
        return label
    }()
    
    private var settingsLabel: UILabel = {
        let label = UILabel()
        label.font = .clashGroteskMedium(size: 20)
        label.text = "Settings"
        label.textColor = .black
        return label
    }()
    
    @objc func deleteHandler() {
        let alert = UIAlertController(title: "", message: "Are you sure you want to delete your account?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            print("User click Delete button")
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User click Cancel button")
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    @objc func goToReminderSettings() {
        let vc = ReminderVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configureComponents() {
        view.addSubview(mainScrollView)
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.contentSize = CGSize(width: view.frame.width, height: 800)
        mainScrollView.addSubview(headerProfile)
        
        mainScrollView.addSubview(aboutMySkinLabel)
        skinType = AboutMySkinUIView(frame: skinType.frame, idCollectionView: 1)
        skinType.iconImage.image = UIImage(named: "skinTypeIcon")
        skinType.namelabel.text = "Skin type"
        skinType.chevronImage.image = UIImage(systemName: "chevron.right")
        mainScrollView.addSubview(skinType)
        
        skinProblem = AboutMySkinUIView(frame: skinType.frame, idCollectionView: 2)
        skinProblem.iconImage.image = UIImage(named: "skinProblemIcon")
        skinProblem.namelabel.text = "Skin problem"
        skinProblem.chevronImage.image = UIImage(systemName: "chevron.right")
        mainScrollView.addSubview(skinProblem)
        
        sensitiveSkin = AboutMySkinUIView(frame: skinType.frame, idCollectionView: 3)
        sensitiveSkin.iconImage.image = UIImage(named: "sensitiveSkinIcon")
        sensitiveSkin.namelabel.text = "Sensitive skin"
        sensitiveSkin.chevronImage.image = UIImage(systemName: "chevron.right")
        mainScrollView.addSubview(sensitiveSkin)
        
        mainScrollView.addSubview(settingsLabel)
        reminderNotification.iconImage.image = UIImage(named: "reminderProfileIcon")
        reminderNotification.namelabel.text = "Reminder notification"
        reminderNotification.chevronImage.image = UIImage(systemName: "chevron.right")
        reminderNotification.isUserInteractionEnabled = true
        let tapReminderNotif = UITapGestureRecognizer(target: self, action: #selector(goToReminderSettings))
        reminderNotification.addGestureRecognizer(tapReminderNotif)
        
        mainScrollView.addSubview(reminderNotification)
        
        deleteAcc.iconImage.image = UIImage(named: "deleteAccIcon")
        deleteAcc.namelabel.text = "Delete user data"
        deleteAcc.namelabel.textColor = UIColor(red: 242/255, green: 53/255, blue: 53/255, alpha: 1)
        let deleteGesture = UITapGestureRecognizer(target: self, action: #selector(deleteHandler))
        deleteAcc.addGestureRecognizer(deleteGesture)
        mainScrollView.addSubview(deleteAcc)
    }
    
    override func configureLayout() {
        mainScrollView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height)
        }
        
        headerProfile.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }
        
        aboutMySkinLabel.snp.makeConstraints { make in
            make.top.equalTo(headerProfile.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        skinType.snp.makeConstraints { make in
            make.top.equalTo(aboutMySkinLabel.snp.bottom).offset(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(70)
        }
        
        skinProblem.snp.makeConstraints { make in
            make.top.equalTo(skinType.snp.bottom).offset(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(90)
        }
        
        sensitiveSkin.snp.makeConstraints { make in
            make.top.equalTo(skinProblem.snp.bottom).offset(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(70)
        }
        
        settingsLabel.snp.makeConstraints { make in
            make.top.equalTo(sensitiveSkin.snp.bottom).offset(40)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        reminderNotification.snp.makeConstraints { make in
            make.top.equalTo(settingsLabel.snp.bottom).offset(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
        }
        
        deleteAcc.snp.makeConstraints { make in
            make.top.equalTo(reminderNotification.snp.bottom).offset(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
        }
    }


}
