//
//  CAGradientLayer+SetGradient.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 05/10/22.
//

import Foundation
import UIKit

extension CAGradientLayer {
    func greenGradient(){
        self.colors = [K.Color.lgreen, K.Color.green]
        self.locations = [0, 0.5]
    }
    
    func yellowGradient(){
        self.colors = [K.Color.lyellow, K.Color.yellow]
        self.locations = [0, 0.5]
    }
    
    func orangeGradient(){
        self.colors = [K.Color.lorange, K.Color.orange]
        self.locations = [0, 0.5]
    }
    
    func redGradient(){
        self.colors = [K.Color.lred, K.Color.red]
        self.locations = [0, 0.5]
    }
    
    func blueGradient(){
        self.colors = [K.Color.lblue, K.Color.blue]
        self.locations = [0, 0.5]
    }
}
