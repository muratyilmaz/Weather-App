//
//  UIImageView+.swift
//  WeatherAPp
//
//  Created by Murat YILMAZ on 5.06.2018.
//  Copyright © 2018 Murat YILMAZ. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public static func makeIconView() -> UIImageView {
        let view = UIImageView(frame: .zero)
        view.contentMode = UIViewContentMode.scaleAspectFit
        view.backgroundColor = UIColor.clear
        return view
    }
}
