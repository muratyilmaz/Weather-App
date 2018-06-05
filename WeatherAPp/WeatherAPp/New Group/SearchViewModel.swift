//
//  SearchViewModel.swift
//  WeatherAPp
//
//  Created by Murat YILMAZ on 5.06.2018.
//  Copyright © 2018 Murat YILMAZ. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SearchViewModel {
    
    typealias Callback = () -> ()
    
    let context: NSManagedObjectContext
    
    var recentQueriedCities: [City] = []
    var reloadData: Callback?
    var onDataFetched: ((ResponseContainer) -> ())?
    var showLoading: Callback?
    var hideLoading: Callback?
    var showError:( (String) -> () )?
    
    var itemCount: Int {
        return recentQueriedCities.count
    }
    
    init() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func fetchQueriedCities() {
        do {
            self.recentQueriedCities = try context.fetch(City.fetchRequest())
            self.reloadData?()
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    func saveCity( cityName: String? ) {
        guard let cityName = cityName,
            !City.isExist(context: context, cityName: cityName) else { return }
        let city = City(context: context)
        city.name = cityName
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func itemName(at indexPath: IndexPath) -> String {
        return self.recentQueriedCities[indexPath.row].name ?? ""
    }
    
    func weatherDataForCity( cityName: String? ) {
        guard let cityNameText = cityName,
            !cityNameText.isEmpty else { return }

        self.showLoading?()
        WeatherService.shared.fetchWeatherData(cityName: cityNameText) { (response, error) in
            if let error = error {
                self.showError?(error.localizedDescription)
                return
            }
            guard let response = response else { return }
            if response.cod == "404" {
                self.showError?("Hava durumu bulunamadı.")
            } else {
                self.hideLoading?()
                DispatchQueue.main.async {
                    self.saveCity(cityName: response.city?.name)
                    self.onDataFetched?(response)
                }
            }
        }
    }
}
