//
//  SectionHeaderFirst.swift
//  demoApp
//
//  Created by Gokalp Altun on 7/23/18.
//  Copyright © 2018 Gokalp Altun. All rights reserved.
//

import Foundation
import UIKit
class SectionHeaderFirst: SectionHeader {
    
    private let _spacingView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.customerNameLabelTextColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    private let _detailLabel : UILabel = {
        let detailLabel = UILabel()
        detailLabel.font = UIFont.boldSystemFont(ofSize: 18)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.textColor =  Constants.detailLabelTextColor
        detailLabel.font = UIFont.boldSystemFont(ofSize: 18)
        detailLabel.layer.cornerRadius = 5
        detailLabel.layer.masksToBounds = true
        return detailLabel
    }()
    
    public var detailLabel : UILabel{
        return _detailLabel
    }
    public var spacingView : UIView{
        return _spacingView
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SectionHeaderFirst {
    private func addSubviews() {
        addSubview(_spacingView)
        addSubview(_detailLabel)
    }
    private func setConstraints() {
        
        detailLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:-10).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: super.provinceLabel.leadingAnchor).isActive = true
        detailLabel.widthAnchor.constraint(equalToConstant: self.frame.width*0.50).isActive = true
        detailLabel.topAnchor.constraint(equalTo: super.provinceLabel.bottomAnchor).isActive = true
        
        _spacingView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        _spacingView.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        _spacingView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        _spacingView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }
}
