//
//  DetailOrderCollectionView.swift
//  demoApp
//
//  Created by Gokalp Altun on 7/23/18.
//  Copyright © 2018 Gokalp Altun. All rights reserved.
//

import Foundation
import UIKit
 class DetailOrderCollectionView: NSObject , UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    var DataSourceArrayForOrderSummary : [[Order]]?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = CommonMethods.rgbaConvertor(r: 20.0, g: 29.0, b: 42.0, a: 1.0)
        collection.dataSource = self
        collection.delegate = self
        collection.register(OrderDetailCell.self, forCellWithReuseIdentifier: "CellMyCell")
        return collection
    }()
    
    
    
    override init() {
        super.init()
        fetchOrders()
    }
    
    
    private func fetchOrders(){
        Service.sharedInstance.fetchOrders { (orders, provinces) in
            let filteredProvinces = CommonMethods.removeDuplicates(array: provinces).sorted()
            self.DataSourceArrayForOrderSummary = CommonMethods.sectionBasedCellPopulation(provinces: filteredProvinces, orders: orders)
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 55)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellMyCell", for: indexPath) as! OrderDetailCell
        
        cell.order = CommonMethods.sordBasedOnDate(dataSource: DataSourceArrayForOrderSummary)[indexPath.item]
        cell.backgroundColor = .white
        return cell
    }
    

    func showCollectionView() {
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(collectionView)
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.collectionView.frame = CGRect(x:0, y: 120, width: self.collectionView.frame.height, height: window.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func dismissCollectionView() {
        UIView.animate(withDuration: 0.5) {
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x:0, y:window.frame.height, width:self.collectionView.frame.width, height:self.collectionView.frame.height)
            }
        }
    }

}


