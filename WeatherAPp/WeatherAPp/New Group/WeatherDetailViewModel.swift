//
//  WeatherDetailViewModel.swift
//  WeatherAPp
//
//  Created by Murat YILMAZ on 5.06.2018.
//  Copyright © 2018 Murat YILMAZ. All rights reserved.
//

import Foundation

class WeatherDetailViewModel {
    private let model: WeatherDataContainer
    init(model: WeatherDataContainer) {
        self.model = model
    }
}

extension WeatherDetailViewModel {
    var title: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self.model.date)
    }
    
    var tempatureText: String {
        return "\(self.model.tempature) °C"
    }
    
    var cloudText: String {
        return "Clouds \(self.model.cloudiness) %"
    }
    
    var windText: String {
        return "Wind \(self.model.windSpeed) m/s"
    }
    
    var pressureText: String {
        return "Pressure \(self.model.pressure) hpa"
    }
    
    var humidityText: String {
        return "Humidity \(self.model.humidity) %"
    }
    
    var iconURLString: String {
        return "\(WeatherService.iconBaseURL)\(model.details[0].icon).png"
    }
}
