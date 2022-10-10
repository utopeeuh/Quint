//
//  RoutineSteps.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 10/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct Product {
    let title: String
}

class RoutineSteps: UIViewController {
    var items = BehaviorSubject(value: [SectionModel(model: "", items: [Product]())])
    
    func fetchItems() {
        let firstSection = SectionModel(model: "", items: [Product(title: "Toner")])
        let secondSection = SectionModel(model: "", items: [Product(title: "Cleanser")])
        let thirdSection = SectionModel(model: "", items: [Product(title: "Serum")])
        let fourthSection = SectionModel(model: "", items: [Product(title: "Moisturizer")])
        let fifthSection = SectionModel(model: "", items: [Product(title: "Sunscreen")])
        let sixthSection = SectionModel(model: "", items: [Product(title: "Eye cream")])
        let seventhSection = SectionModel(model: "", items: [Product(title: "Acne care")])
        let eightSection = SectionModel(model: "", items: [Product(title: "Exfoliator")])
        self.items.on(.next([firstSection, secondSection, thirdSection, fourthSection, fifthSection, sixthSection, seventhSection, eightSection]))
    }
}
