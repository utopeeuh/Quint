//
//  RejectedCameraAlert.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 09/11/22.
//

import Foundation
import UIKit

extension UIAlertController{
    
    static func rejectedCameraAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Camera Permission Denied", message: "Please enable the camera from your settings.", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Go to settings", style: .default) { (_) -> Void in

            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        
        alert.addAction(settingsAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        
        return alert
    }
}
