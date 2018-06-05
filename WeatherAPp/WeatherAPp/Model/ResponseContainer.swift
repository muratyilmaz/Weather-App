//
//  ResponseContainer.swift
//  WeatherAPp
//
//  Created by Murat YILMAZ on 4.06.2018.
//  Copyright © 2018 Murat YILMAZ. All rights reserved.
//

import Foundation

struct ResponseContainer {
    struct City: Decodable {
        let name: String
    }
    
    enum CodingKeys: String, CodingKey {
        case list
        case city
        case cod
    }
    
    let list: [WeatherDataContainer]?
    let city: City?
    let cod: String
}

extension ResponseContainer: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        list = try container.decodeIfPresent([WeatherDataContainer].self, forKey: .list)
        city = try container.decodeIfPresent(City.self, forKey: .city)
        cod = try container.decode(String.self, forKey: .cod)
    }
}
