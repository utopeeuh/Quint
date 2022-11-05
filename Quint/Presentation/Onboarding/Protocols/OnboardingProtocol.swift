//
//  OnboardingProtocolVC.swift
//  Quint
//
//  Created by Vendly on 21/10/22.
//

import UIKit

protocol AllowNotificationDelegate {
    
    func allowNotif() -> Void
    
}

protocol PhotoConfirmationVCDelegate: AnyObject {
    
    func didTapConfirmButton() -> Void
    
    func didTapCancelButton() -> Void
    
}
