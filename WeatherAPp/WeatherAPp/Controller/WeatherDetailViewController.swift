//
//  WeatherDetailViewController.swift
//  WeatherAPp
//
//  Created by Murat YILMAZ on 5.06.2018.
//  Copyright © 2018 Murat YILMAZ. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    private lazy var tempatureLabel: UILabel = UILabel.makeLabel(alignment: .center,
                                                                 font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.black))
    private lazy var cloudLabel: UILabel = UILabel.makeLabel(alignment: .center)
    private lazy var windLabel: UILabel = UILabel.makeLabel(alignment: .center)
    private lazy var humidityLabel: UILabel = UILabel.makeLabel(alignment: .center)
    private lazy var pressureLabel: UILabel = UILabel.makeLabel(alignment: .center)
    private lazy var iconView: UIImageView = UIImageView.makeIconView()
    
    var onTapClose: (() -> ())?
    var viewModel: WeatherDetailViewModel!
    
    convenience init(viewModel: WeatherDetailViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    deinit {
        print("☠️ WeatherDetailViewController deallocated")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = self.viewModel.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.plain, target: self, action: #selector(close))
        view.backgroundColor = UIColor.white
        
        setupViews()
        bindViewModel()
    }
    
    @objc func close() {
        self.onTapClose?()
    }
    
    private func setupViews() {
        view.addSubview(iconView)
        iconView.size(CGSize(width: 50, height: 50))
        iconView.topToSuperview(offset:32, usingSafeArea: true)
        iconView.centerXToSuperview()
        
        let labelsContainer = UIView()
        view.addSubview(labelsContainer)
        labelsContainer.topToBottom(of: iconView, offset:32)
        labelsContainer.leadingToSuperview()
        labelsContainer.trailingToSuperview()
        labelsContainer.stack([tempatureLabel,cloudLabel, windLabel, humidityLabel], axis: .vertical, spacing: 4)
    }
    
    private func bindViewModel() {
        if let url = URL(string: self.viewModel.iconURLString) {
            iconView.kf.setImage(with: url)
        }
        tempatureLabel.text = self.viewModel.tempatureText
        cloudLabel.text = self.viewModel.cloudText
        windLabel.text = self.viewModel.windText
        pressureLabel.text = self.viewModel.pressureText
        humidityLabel.text = self.viewModel.humidityText
    }
}
