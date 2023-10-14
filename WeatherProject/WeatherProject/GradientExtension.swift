//
//  GradientExtension.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import Foundation
import UIKit

extension CAGradientLayer {
    static func getGradientLayer(in frame: CGRect) -> Self {
        let layer = Self()
        layer.colors = getColors()
        layer.frame = frame
        return layer
    }
    
    private static func getColors() -> [CGColor] {
        let beginColor: CGColor = UIColor(named: "startColor")!.cgColor
        let endColor: CGColor = UIColor(named: "endColor")!.cgColor
        
        return [beginColor, endColor]
    }
}
