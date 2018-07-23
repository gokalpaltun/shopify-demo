//
//  OrderCell.swift
//  demoApp
//
//  Created by Gokalp Altun on 7/14/18.
//  Copyright © 2018 Gokalp Altun. All rights reserved.
//

import UIKit



class OrderCell: UICollectionViewCell {
    var order:Order?{
        didSet{    
            if let itemsCount = order?.itemsCount,
                let address = order?.addres,
                let price = order?.totalPrice,
                let date = order?.date{
                numberOfOrders.text = "\(itemsCount)"
                orderAddressLabel.text = address
                orderTotalPrice.text = "\(price)"
                let calendar = Calendar.current
                let year = calendar.component(.year, from: date)
                let month = calendar.component(.month, from: date)
                let day = calendar.component(.day, from: date)
                orderDate.text = "\(year).\(month).\(day)"
            }
        }
    }

    public var numberOfOrders: UILabel {
        return _numberOfOrders
    }
    public var orderAddressLabel : UILabel {
        return _orderAddressLabel
    }
    public var orderTotalPrice : UILabel {
        return _orderTotalPrice
    }
    public var orderDate : UILabel {
        return _orderDate
    }
    public var spacingView : UIView {
        return _spacingView
    }
    
    private let _numberOfOrders : UILabel = {
        let numberOfOrders = UILabel()
        numberOfOrders.translatesAutoresizingMaskIntoConstraints = false
        numberOfOrders.font = UIFont.boldSystemFont(ofSize: 25)
        numberOfOrders.textColor = CommonMethods.rgbaConvertor(r: 15.0, g: 27.0, b: 41.0, a: 1.0)
        numberOfOrders.layer.masksToBounds = true
        numberOfOrders.layer.cornerRadius = 5
        return numberOfOrders
    }()
 
    
    private let _orderAddressLabel : UILabel = {
        let orderAddressLabel = UILabel()
    orderAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        orderAddressLabel.font = UIFont.boldSystemFont(ofSize: 18)
        orderAddressLabel.numberOfLines = 2
        orderAddressLabel.textColor = CommonMethods.rgbaConvertor(r: 177.0, g: 177.0, b: 177.0, a: 1.0)
        orderAddressLabel.layer.masksToBounds = true
        orderAddressLabel.layer.cornerRadius = 5
        return orderAddressLabel
    }()

    private let _orderTotalPrice : UILabel = {
        let totalPrice = UILabel()
        totalPrice.translatesAutoresizingMaskIntoConstraints = false
        totalPrice.font = UIFont.boldSystemFont(ofSize: 25)
        totalPrice.textColor = CommonMethods.rgbaConvertor(r: 20.0, g: 162.0, b: 82.0, a: 1)
        totalPrice.textAlignment = .right
        totalPrice.layer.masksToBounds = true
        totalPrice.layer.cornerRadius = 5
        return totalPrice
    }()

    private let _orderDate : UILabel = {
        let orderDate = UILabel()
        orderDate.translatesAutoresizingMaskIntoConstraints = false
        orderDate.font = UIFont.boldSystemFont(ofSize: 21)
        orderDate.textColor = CommonMethods.rgbaConvertor(r: 15.0, g: 27.0, b: 41.0, a: 1.0)
        orderDate.textAlignment = .right
        orderDate.layer.masksToBounds = true
        orderDate.layer.cornerRadius = 5
        return orderDate
    }()
    
     private let _spacingView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CommonMethods.rgbaConvertor(r: 177, g: 177, b: 177, a: 1.0)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setConstraints()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OrderCell {
    private func addSubViews() {
        addSubview(_numberOfOrders)
        addSubview(_orderAddressLabel)
        addSubview(_orderTotalPrice)
        addSubview(_orderDate)
        addSubview(_spacingView)
    }
    private func setConstraints() {
        _numberOfOrders.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        _numberOfOrders.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        _numberOfOrders.heightAnchor.constraint(equalToConstant: self.frame.height * 0.20).isActive = true
        _numberOfOrders.widthAnchor.constraint(equalToConstant: self.frame.width * 0.23).isActive = true
        
        _orderAddressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        _orderAddressLabel.topAnchor.constraint(equalTo: numberOfOrders.bottomAnchor, constant: 10).isActive = true
        _orderAddressLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        _orderAddressLabel.widthAnchor.constraint(equalToConstant: self.frame.width*0.65).isActive = true
        
        _orderTotalPrice.topAnchor.constraint(equalTo: numberOfOrders.bottomAnchor, constant: 10).isActive = true
        _orderTotalPrice.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        _orderTotalPrice.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        _orderTotalPrice.widthAnchor.constraint(equalToConstant: self.frame.width*0.28).isActive = true
        
        _orderDate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        _orderDate.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        _orderDate.heightAnchor.constraint(equalToConstant: self.frame.height * 0.20).isActive = true
        _orderDate.widthAnchor.constraint(equalToConstant: self.frame.width * 0.33).isActive = true
        
        _spacingView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        _spacingView.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        _spacingView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        _spacingView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }
}

