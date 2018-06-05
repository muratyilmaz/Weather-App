//
//  WeatherTableViewCell.swift
//  WeatherAPp
//
//  Created by Murat YILMAZ on 5.06.2018.
//  Copyright © 2018 Murat YILMAZ. All rights reserved.
//

import UIKit
import Kingfisher

class WeatherTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "weatherCellId"
    
    private lazy var dateLabel: UILabel = UILabel.makeLabel(font: UIFont.systemFont(ofSize: 14))
    private lazy var tempatureLabel: UILabel = UILabel.makeLabel(alignment: .right, font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.black))
    private lazy var iconView: UIImageView = UIImageView.makeIconView()
    
    let formatter = DateFormatter()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let stackLeft = UIStackView(arrangedSubviews: [dateLabel, iconView])
        stackLeft.axis = .vertical
        contentView.addSubview(stackLeft)
        stackLeft.leftToSuperview(offset: 8)
        stackLeft.topToSuperview(offset: 8)
        stackLeft.bottomToSuperview(offset: -8)
        
        let stackRight = UIStackView(arrangedSubviews: [tempatureLabel])
        stackRight.axis = .vertical
        contentView.addSubview(stackRight)
        stackRight.rightToSuperview(offset: 8)
        stackRight.topToSuperview(offset: 8)
        stackRight.bottomToSuperview(offset: -8)
    }
    
    public func configureCell( data: WeatherDataContainer ) {
        dateLabel.text = formatter.string(from: data.date)
        tempatureLabel.text = "\(data.tempature) °C"
        if let url = URL(string: "\(WeatherService.iconBaseURL)\(data.details[0].icon).png") {
            iconView.kf.setImage(with: url)
        }
    }
}
