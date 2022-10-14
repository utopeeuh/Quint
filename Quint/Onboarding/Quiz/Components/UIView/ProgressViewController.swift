//
//  ProgressViewController.swift
//  Quint
//
//  Created by Vendly on 13/10/22.
//

import UIKit
import SnapKit

class ProgressViewController: UIViewController {
    
    let navBarView = QuizNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(navBarView)
        navBarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview().offset(-40)
        }
        
    }
    
    @objc func didTapBack() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
}
