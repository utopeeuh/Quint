//
//  ViewControllerPreview.swift
//  tracco
//
//  Created by Ramadhan Kalih Sewu on 05/10/22.
//

import UIKit
import SwiftUI

struct ViewControllerPreview: UIViewControllerRepresentable
{
    let viewControllerBuilder: () -> UIViewController

    init(_ viewControllerBuilder: @escaping () -> UIViewController) {
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return viewControllerBuilder()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Not needed
    }
}
