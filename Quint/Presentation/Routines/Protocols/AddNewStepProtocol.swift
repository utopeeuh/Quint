//
//  AddNewStepProtocol.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 04/11/22.
//

import Foundation
import UIKit

protocol AddNewStepDelegate {
    func addedNewStep()
}


//class FirstViewController: UIViewController {
//
//@IBAction func start(_ sender: Any) {
//       guard let secondController = self.storyboard?.instantiateViewController(withIdentifier: "SecondController") as? SecondController else { return }
//        secondController.delegate = self
//    self.navigationController?.pushViewController(secondController, animated: true)
//   }
//
//}
//
//extension ViewController : ViewControllerSecDelegate {
//
//    func didBackButtonPressed(){
//         print("Do your stuff")
//    }
//}
////--------------------------
//
//class SecondController: UIViewController {
//
//    weak var delegate: SecondControllerDelegate?
//
//         override func viewWillDisappear(_ animated: Bool) {
//              delegate?.didBackButtonPressed()
//         }
// }
