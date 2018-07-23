//
//  SectionHeader.swift
//  demoApp
//
//  Created by Gokalp Altun on 7/14/18.
//  Copyright © 2018 Gokalp Altun. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionViewCell {
    
    var order : Order? {
        didSet {
            if let province = order?.province, let country = order?.countryCode{
                self._provinceLabel.text = province
                self._countryLabel.text = country
            } 
        }
    }
    public var provinceLabel : UILabel{
        return _provinceLabel
    }
    public var countryLabel : UILabel{
        return _countryLabel
    }
    
    private let _provinceLabel : UILabel = {
        let provinceLabel = UILabel()
        provinceLabel.font = UIFont.boldSystemFont(ofSize: 45)
        provinceLabel.textColor =  Constants.sectionHeaderTextColor
        provinceLabel.translatesAutoresizingMaskIntoConstraints = false
        provinceLabel.layer.cornerRadius = 5
        provinceLabel.layer.masksToBounds = true
        return provinceLabel
    }()
    
    private let _countryLabel : UILabel = {
        let countryLabel = UILabel()
        countryLabel.font = UIFont.boldSystemFont(ofSize: 18)
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.textColor =  Constants.sectionHeaderTextColor
        countryLabel.layer.cornerRadius = 5
        countryLabel.layer.masksToBounds = true
        return countryLabel
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SectionHeader {
    private func addSubviews() {
        self.addSubview(provinceLabel)
        self.addSubview(countryLabel)
    }
    
    private func setConstraints() {
        provinceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        provinceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -35).isActive = true
        provinceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        provinceLabel.widthAnchor.constraint(equalToConstant: self.frame.width*0.75).isActive = true
        
        countryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        countryLabel.leadingAnchor.constraint(equalTo: provinceLabel.trailingAnchor, constant: 10).isActive = true
        countryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:-10 ).isActive = true
        countryLabel.heightAnchor.constraint(equalToConstant: self.frame.height*0.30).isActive = true
    }
}
