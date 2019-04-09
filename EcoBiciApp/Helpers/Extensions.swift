//
//  Extensions.swift
//  EcoBiciApp
//
//  Created by Héctor Bautista on 4/7/19.
//  Copyright © 2019 Héctor Bautista. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setShadowView(_ roundedCorners: Bool = true) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.2
        if roundedCorners {
            self.layer.cornerRadius = 20.0
        }
    }
}

