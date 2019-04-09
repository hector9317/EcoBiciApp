//
//  Utils.swift
//  EcoBiciApp
//
//  Created by Héctor Bautista on 4/7/19.
//  Copyright © 2019 Héctor Bautista. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static func getController(storyboard: String, controller: String) -> UIViewController{
        return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: controller)
    }
}
