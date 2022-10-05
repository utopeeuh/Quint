//
//  TodayRoutine.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 05/10/22.
//

import UIKit
import RxSwift
import RxCocoa

struct Routine {
    let imageDoneLock: String
    let imageName: String
    let title: String
}

class TodayRoutineViewModel: UIViewController {
    var items = PublishSubject<[Routine]>()
    
    func fetchItems() {
        let routines = [
            Routine(imageDoneLock: "circle", imageName: "iconMorning", title: "Morning Routine"),
            Routine(imageDoneLock: "circle",imageName: "iconNight", title: "Night Routine"),
            Routine(imageDoneLock: "lock",imageName: "iconLog", title: "Daily skin condition log")
        ]
        
        items.onNext(routines)
        items.onCompleted()
    }
}
