//
//  AppRouter.swift
//  WeatherAPp
//
//  Created by Murat YILMAZ on 5.06.2018.
//  Copyright © 2018 Murat YILMAZ. All rights reserved.
//

import Foundation
import UIKit

class AppRouter {
    
    let navigationController = UINavigationController()
    
    init(window: UIWindow) {
        window.rootViewController = navigationController
        showSearch()
    }
    
    private func showSearch() {
        let viewModel = SearchViewModel()
        let searchViewController = SearchViewController(viewModel: viewModel)
        searchViewController.onDataFetched = showWeatherListForCity
        navigationController.setViewControllers([searchViewController], animated: false)
    }
    
    private func showWeatherListForCity(response: ResponseContainer) {
        let viewModel = CityWeatherListViewModel(model: response)
        let cityWeatherListVC = CityWeatherListViewController(viewModel: viewModel)
        cityWeatherListVC.onSelect = showWeatherDetails
        navigationController.pushViewController(cityWeatherListVC, animated: true)
    }
    
    private func showWeatherDetails(weatherDetail: WeatherDataContainer ) {
        let viewModel = WeatherDetailViewModel(model: weatherDetail)
        let detailVC = WeatherDetailViewController(viewModel: viewModel)
        detailVC.onTapClose = { [weak self] in
            self?.navigationController.dismiss(animated: true)
        }
        let detailNVC = UINavigationController(rootViewController: detailVC)
        navigationController.present(detailNVC, animated: true)
    }
}
