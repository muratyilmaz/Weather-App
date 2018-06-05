//
//  WeatherDataContainer.swift
//  WeatherAPp
//
//  Created by Murat YILMAZ on 5.06.2018.
//  Copyright © 2018 Murat YILMAZ. All rights reserved.
//

import Foundation

struct WeatherDataContainer {
    
    struct WeatherDetail: Decodable {
        let icon: String
        let description: String
    }
    
    let tempature: Float
    let details: [WeatherDetail]
    let dateText:String
    let windSpeed: Float
    let cloudiness: Int
    let humidity: Int
    let pressure: Float
    
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: self.dateText)!
    }
    
    enum CodingKeys: String, CodingKey {
        case tempature = "main"
        case temp
        case pressure
        case humidity
        case details = "weather"
        case dateText = "dt_txt"
        case wind
        case windSpeed = "speed"
        case clouds
        case cloudsAll = "all"
    }
}

extension WeatherDataContainer: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        details = try container.decode([WeatherDetail].self, forKey: .details)
        dateText = try container.decode(String.self, forKey: .dateText)
        
        let main = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .tempature)
        tempature = try main.decode(Float.self, forKey: .temp)
        humidity = try main.decode(Int.self, forKey: .humidity)
        pressure = try main.decode(Float.self, forKey: .pressure)
        
        let wind = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .wind)
        windSpeed = try wind.decode(Float.self, forKey: .windSpeed)
        
        let clouds = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .clouds)
        cloudiness = try clouds.decode(Int.self, forKey: .cloudsAll)
    }
}
