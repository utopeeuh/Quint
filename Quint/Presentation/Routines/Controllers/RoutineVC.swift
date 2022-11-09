//
//  RoutineVC.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 04/10/22.
//
import CoreLocation
import UIKit
import WeatherKit
import AVFoundation

@available(iOS 16.0, *)
class RoutineVC: UIViewController, CLLocationManagerDelegate, LogModalDelegate {

    private var whiteTopBar = UIView()
    private var uvSection = UVSection()
    private var reminderView = ReminderUIView()
    
    private var routineLbl = UILabel()
    private var morningRoutine = MorningRoutineCell()
    private var nightRoutine = NightRoutineCell()
    private var logRoutine = LogRoutineCell()
    
    private var logFaceImage : UIImage?
    
    private lazy var routineCellsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    private var dailyTips = DailySkincareTips()
    
    private var logModal = LogModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        configureUI()
        checkDoneRoutines()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUV()
        logModal.hide()
    }
    
    func updateUV(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .restricted, .denied:
                    uvSection.disable()
            case .authorizedAlways, .authorizedWhenInUse, .notDetermined:
                    uvSection.enable()
                @unknown default:
                    break
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        updateUV()
    }

    override func configureComponents() {
        
        whiteTopBar.backgroundColor = .white
        
        routineLbl.text = "Today's routines"
        routineLbl.font = .clashGroteskMedium(size: 20)
        
        // morning routine
        let morningGesture = UITapGestureRecognizer(target: self, action: #selector(goToMorningRoutine))
        morningRoutine.addGestureRecognizer(morningGesture)
        morningRoutine.currStack = routineCellsStack
        
        let nightGesture = UITapGestureRecognizer(target: self, action: #selector(goToNightRoutine))
        nightRoutine.addGestureRecognizer(nightGesture)
        nightRoutine.currStack = routineCellsStack
        
        let logGesture = UITapGestureRecognizer(target: self, action: #selector(goToLog))
        logRoutine.addGestureRecognizer(logGesture)
        logRoutine.currStack = routineCellsStack
        
        // MARK: - ROUTINE
        routineCellsStack.addArrangedSubview(morningRoutine)
        routineCellsStack.addArrangedSubview(nightRoutine)
        routineCellsStack.addArrangedSubview(logRoutine)
        
        routineCellsStack.arrangedSubviews.forEach { view in
            if let v = view as? RoutineCell{
                v.delegate = self
            }
        }
        
        logModal.delegate = self
    }
    
    override func configureLayout() {
        
        view.multipleSubviews(view: whiteTopBar, uvSection, reminderView, routineLbl, routineCellsStack, dailyTips, logModal)
        
        whiteTopBar.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        uvSection.snp.makeConstraints { make in
            make.top.equalTo(whiteTopBar.snp.bottom).offset(-3)
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(70)
        }
        
        reminderView.snp.makeConstraints { make in
            make.height.equalTo(reminderView.height)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width-40)
            make.top.equalTo(uvSection.snp.bottom).offset(28)
        }
        
        routineLbl.snp.makeConstraints { make in
            make.top.equalTo(reminderView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
        }
        
        routineCellsStack.snp.makeConstraints { make in
            make.top.equalTo(routineLbl.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width-40)
            make.height.equalTo(60*3+24)
        }
        
        routineCellsStack.arrangedSubviews.forEach { subview in
            subview.snp.makeConstraints { make in
                make.height.equalTo(60)
                make.width.equalToSuperview()
                make.centerX.equalToSuperview()
            }
        }
        
        dailyTips.snp.makeConstraints { make in
            make.height.equalTo(dailyTips.height)
            make.width.equalTo(UIScreen.main.bounds.width-40)
            make.centerX.equalToSuperview()
            make.top.equalTo(routineCellsStack.snp.bottom).offset(48)
        }
        
        logModal.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func checkDoneRoutines(){
        if(LogRepository.shared.doesLogExists(date: Date.now)){
            let currDayLog = LogRepository.shared.fetchLog(date: Date.now)
            
            if currDayLog.isDayDone == true {
                morningRoutine.pressed()
            }
            
            if currDayLog.isNightDone == true {
                nightRoutine.pressed()
            }
        }
    }
    
    @objc func goToMorningRoutine(sender: UITapGestureRecognizer) {
        let controller = RoutineDetailVC()
        controller.routineTime = .morning
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func goToNightRoutine(sender: UITapGestureRecognizer) {
        let controller = RoutineDetailVC()
        controller.routineTime = .night
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
}

@available(iOS 16.0, *)
extension RoutineVC: RoutineReminderDelegate{
    func hideRoutineReminder() {
        
        if(nightRoutine.isChecked && !logRoutine.isChecked){
            logModal.show()
        }
        
        if reminderView.isHidden == true{
            return
        }
        
        reminderView.hide()
        
        let moveUpHeight = -(reminderView.height + 40)
        
        let moveViews = [routineLbl, routineCellsStack, dailyTips]
        UIView.animate(withDuration: 0.4, animations: {
            moveViews.forEach { view in
                view.transform = CGAffineTransform(translationX: 0, y: moveUpHeight)
            }
        })
    }
}

@available(iOS 16.0, *)
extension RoutineVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate, PhotoConfirmationVCDelegate{
    
    @objc func goToLog() {

        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  .denied {
            // If camera permission denied, show alert
            let alert = UIAlertController.rejectedCameraAlert()
            self.present(alert, animated: true, completion: nil)
            return
            
        } else{
        
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.cameraDevice = .front
            picker.delegate = self
            picker.cameraFlashMode = .off
            present(picker, animated: true)
        }
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .denied {
            // If camera permission is denied
            return
        }
        
        let controller = PhotoConfirmationVC()
        controller.delegate = self
        
        if let image = info[.originalImage] as? UIImage {
            logFaceImage = image
            controller.chosenImage = logFaceImage
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didTapConfirmButton() {
        let controller = DailyLogVC()
        controller.faceImage = logFaceImage!
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didTapCancelButton() {
        navigationController?.popViewController(animated: true)
    }
}

@available(iOS 16.0, *)
extension RoutineVC: RoutineDetailDelegate{
    func didTapFinish(time: K.RoutineTime) {
        switch time {
        case .morning:
            morningRoutine.pressed()
        default:
            nightRoutine.pressed()
        }
    }
}

