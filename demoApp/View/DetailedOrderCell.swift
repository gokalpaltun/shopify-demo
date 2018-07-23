//
//  DetailedOrderCell.swift
//  demoApp
//
//  Created by Gokalp Altun on 7/23/18.
//  Copyright © 2018 Gokalp Altun. All rights reserved.
//

import UIKit

class OrderDetailCell: UICollectionViewCell{
    
    var order: Order?{
        didSet{
            if let cEmail = order?.email, let cName = order?.customerName, let cSurname = order?.customerSurname{
                email.text = cEmail
                customerName.text = cName + cSurname
            }
            
        }
    }
    
    public var email: UILabel {
        return _email
    }
    public var customerName : UILabel {
        return _customerName
    }
    
    private let _email : UILabel = {
        let email = UILabel()
        email.translatesAutoresizingMaskIntoConstraints = false
        email.font = UIFont.boldSystemFont(ofSize: 20)
        email.textColor = Constants.emailLabelTextColor
        email.layer.masksToBounds = true
        email.layer.cornerRadius = 5
        return email
    }()
    
    
    private let _customerName : UILabel = {
        let customerName = UILabel()
        customerName.translatesAutoresizingMaskIntoConstraints = false
        customerName.font = UIFont.boldSystemFont(ofSize: 16)
        customerName.numberOfLines = 2
        customerName.textColor = Constants.customerNameLabelTextColor
        customerName.layer.masksToBounds = true
        customerName.layer.cornerRadius = 5
        return customerName
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

extension OrderDetailCell {
    private func addSubViews() {
        addSubview(_email)
        addSubview(_customerName)
        
    }
    private func setConstraints() {
        _email.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        _email.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        _email.heightAnchor.constraint(equalToConstant: self.frame.height * 0.40).isActive = true
        _email.widthAnchor.constraint(equalToConstant: self.frame.width * 0.60).isActive = true
        
        _customerName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        _customerName.heightAnchor.constraint(equalToConstant: self.frame.height * 0.30).isActive = true
        _customerName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        _customerName.widthAnchor.constraint(equalToConstant: self.frame.width*0.65).isActive = true
        
    }
}

