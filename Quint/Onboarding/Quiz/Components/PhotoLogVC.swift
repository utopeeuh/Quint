//
//  SelfieVC.swift
//  Quint
//
//  Created by Vendly on 11/10/22.
//

import UIKit

class PhotoLogVC: UIViewController {
    
    @objc func didTapBack() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapPhoto() {
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.cameraDevice = .front
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
}

extension PhotoLogVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        
        picker.dismiss(animated: true, completion: nil)
        
        let controller = PhotoConfirmationVC()
        controller.chosenImage = image
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
