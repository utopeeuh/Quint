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
        self.colors = [K.Color.greenLightQuint, K.Color.greenQuint]
        self.locations = [0, 0.5]
    }
    
    func yellowGradient(){
        self.colors = [K.Color.yellowLightQuint, K.Color.yellowQuint]
        self.locations = [0, 0.5]
    }
    
    func orangeGradient(){
        self.colors = [K.Color.orangeLightQuint, K.Color.orangeQuint]
        self.locations = [0, 0.5]
    }
    
    func redGradient(){
        self.colors = [K.Color.redLightQuint, K.Color.redQuint]
        self.locations = [0, 0.5]
    }
    
    func purpleGradient(){
        self.colors = [K.Color.purpleLightQuint, K.Color.purpleQuint]
        self.locations = [0, 0.5]
    }
}
