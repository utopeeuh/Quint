//
//  TodayRoutine.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 05/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct Routine {
    let imageDoneLock: String
    let imageName: String
    let title: String
}

class TodayRoutineViewModel: UIViewController {
    var items = BehaviorSubject(value: [SectionModel(model: "", items: [Routine]())])
    
    func fetchItems() {
        
        let firstSection = SectionModel(model: "first", items: [Routine(imageDoneLock: "circle",imageName: "iconMorning", title: "Morning Routine")])
        let secondSection = SectionModel(model: "second", items: [Routine(imageDoneLock: "circle",imageName: "iconNight", title: "Night Routine")])
        let thirdSection = SectionModel(model: "third", items: [Routine(imageDoneLock: "lock",imageName: "iconLog", title: "Daily skin condition log")])
        
        
        self.items.on(.next([firstSection,secondSection,thirdSection]))
    }
}
