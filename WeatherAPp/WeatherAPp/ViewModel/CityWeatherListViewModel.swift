//
//  CityWeatherListViewModel.swift
//  WeatherAPp
//
//  Created by Murat YILMAZ on 5.06.2018.
//  Copyright © 2018 Murat YILMAZ. All rights reserved.
//

import Foundation

class CityWeatherListViewModel {
    private let model: ResponseContainer
    init(model: ResponseContainer) {
        self.model = model
    }
}

extension CityWeatherListViewModel {
    var cityName: String {
        return self.model.city?.name ?? ""
    }
    
    var itemCount: Int {
        return self.model.list?.count ?? 0
    }
    
    func item(at indexPath: IndexPath) -> WeatherDataContainer? {
        return self.model.list?[indexPath.row] ?? nil
    }
}
