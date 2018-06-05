//
//  ViewController.swift
//  WeatherAPp
//
//  Created by Murat YILMAZ on 4.06.2018.
//  Copyright © 2018 Murat YILMAZ. All rights reserved.
//

import UIKit
import TinyConstraints
import SVProgressHUD
import CoreData

class SearchViewController: UIViewController {
    
    let cityCellIdentifier = "cityCellId"
    let sectionTitleString = "Recent Queried Cities"
    
    private lazy var searchTextfield: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = UIColor.lightGray
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        textField.placeholder = "Type city name"
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cityCellIdentifier)
        return tableView
    }()
    
    var viewModel: SearchViewModel!
    //
    var onDataFetched: ( (ResponseContainer) -> () )?

    convenience init(viewModel: SearchViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = UIColor.white
        navigationItem.title = "Weather App"
        
        bindViewModel()
        setupSearchTextfield()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchTextfield.text = ""
        self.viewModel.fetchQueriedCities()
    }
    
    private func bindViewModel() {
        self.viewModel.reloadData = { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        self.viewModel.onDataFetched = self.onDataFetched
        self.viewModel.showLoading = { DispatchQueue.main.async { SVProgressHUD.show() } }
        self.viewModel.hideLoading = { DispatchQueue.main.async { SVProgressHUD.dismiss() } }
        self.viewModel.showError = { [unowned self] errorMessage in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.showAlert(errorMessage)
            }
        }
    }
}

private extension SearchViewController {
    func setupSearchTextfield() {
        view.addSubview(searchTextfield)
        searchTextfield.topToSuperview(usingSafeArea: true)
        searchTextfield.leadingToSuperview(offset: 0)
        searchTextfield.trailingToSuperview(offset: 0)
        searchTextfield.height(40)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.topToBottom(of: searchTextfield)
        tableView.leadingToSuperview()
        tableView.trailingToSuperview()
        tableView.bottomToSuperview(usingSafeArea: true)
    }
}

// MARK: UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        viewModel.weatherDataForCity(cityName: textField.text)
        return true
    }
}

// MARK: UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.weatherDataForCity(cityName: viewModel.itemName(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleString
    }
}

// MARK: UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cityCellIdentifier, for: indexPath)
        cell.textLabel?.text = self.viewModel.itemName(at: indexPath)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

