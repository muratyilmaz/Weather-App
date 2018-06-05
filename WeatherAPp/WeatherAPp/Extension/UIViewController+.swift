//
//  UIViewController+.swift
//  WeatherAPp
//
//  Created by Murat YILMAZ on 5.06.2018.
//  Copyright © 2018 Murat YILMAZ. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
