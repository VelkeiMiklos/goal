//
//  UIButtonExt.swift
//  GoalApp
//
//  Created by Velkei Miklós on 2017. 11. 05..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
extension UIButton {
    
    func setSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.3015393019, green: 0.7494100928, blue: 0.3338966966, alpha: 1)
    }
    
    func setDeselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.6840927005, green: 0.9034651518, blue: 0.6715587974, alpha: 1)
    }
}
