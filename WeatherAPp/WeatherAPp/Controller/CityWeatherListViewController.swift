//
//  CityWeatherListViewController.swift
//  WeatherAPp
//
//  Created by Murat YILMAZ on 5.06.2018.
//  Copyright © 2018 Murat YILMAZ. All rights reserved.
//

import UIKit

class CityWeatherListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableViewStyle.plain)
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        return tableView
    }()
    
    var onSelect: ( (WeatherDataContainer) -> () )?
    var viewModel: CityWeatherListViewModel!
    
    convenience init(viewModel: CityWeatherListViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    deinit {
        print("☠️ CityWeatherListViewController deallocated")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = self.viewModel.cityName
        setupTableView()
    }
}

private extension CityWeatherListViewController {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.topToSuperview(usingSafeArea: true)
        tableView.leadingToSuperview()
        tableView.trailingToSuperview()
        tableView.bottomToSuperview(usingSafeArea: true)
    }
}

// MARK: UITableViewDelegate
extension CityWeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let weatherData = self.viewModel.item(at: indexPath) {
            self.onSelect?(weatherData)
        }
    }
}

// MARK: UITableViewDataSource
extension CityWeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.reuseIdentifier, for: indexPath) as? WeatherTableViewCell else {
            fatalError("Error dequeueReusableCell \(WeatherTableViewCell.reuseIdentifier)")
        }
        if let cellData = self.viewModel.item(at: indexPath) {
            cell.configureCell(data: cellData)
        }
        return cell
    }
}
