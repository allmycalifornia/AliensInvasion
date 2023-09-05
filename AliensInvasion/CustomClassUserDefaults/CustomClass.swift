//
//  CustomClass.swift
//  AliensInvasion
//
//  Created by Борис Кравченко on 05.09.2023.
//

import UIKit

final class CustomClass: Codable {
    var name: String
    var scroll: CGFloat
    var loadValue: String
    var loadStepper: Double
    
    init(name: String, scroll: CGFloat, loadValue: String, loadStepper: Double) {
        self.name = name
        self.scroll = scroll
        self.loadValue = loadValue
        self.loadStepper = loadStepper
    }
}
