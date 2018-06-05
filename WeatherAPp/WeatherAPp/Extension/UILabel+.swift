//
//  UILabel+.swift
//  WeatherAPp
//
//  Created by Murat YILMAZ on 5.06.2018.
//  Copyright © 2018 Murat YILMAZ. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    public static func makeLabel( text: String? = nil, alignment: NSTextAlignment = .left, font: UIFont? = nil ) -> UILabel {
        let label = UILabel(frame: .zero)
        if let text = text {
            label.text = text
        }
        label.textAlignment = alignment
        if let font = font {
            label.font = font
        }
        return label
    }
}
