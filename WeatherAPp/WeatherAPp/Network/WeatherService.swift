//
//  WeatherService.swift
//  WeatherAPp
//
//  Created by Murat YILMAZ on 5.06.2018.
//  Copyright © 2018 Murat YILMAZ. All rights reserved.
//

import Foundation

class WeatherService {
    
    typealias Response = (ResponseContainer?, Error?) -> ()
    
    static let shared = WeatherService()
    static let iconBaseURL = "https://openweathermap.org/img/w/"
    
    private let apiKey = "8827fbf408dc7e1418f3c1e84596334c"
    private let apiBaseURL = "https://api.openweathermap.org/data/2.5/forecast?"
    
    public func fetchWeatherData( cityName: String, completion: @escaping Response ) {
        
        guard let urlString = "\(apiBaseURL)q=\(cityName)&mode=json&units=metric&APPID=\(apiKey)" .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: urlString) else {
                return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
                return
            }
            
            do {
                let container = try JSONDecoder().decode(ResponseContainer.self, from: data!)
                completion(container, nil)
            } catch {
                print("decoding error: \(error.localizedDescription)")
                completion(nil, error)
            }
            
        }.resume()
    }
}
