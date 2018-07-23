//
//  ViewController.swift
//  demoApp
//
//  Created by Gokalp Altun on 7/14/18.
//  Copyright © 2018 Gokalp Altun. All rights reserved.
//

import UIKit

class OrderDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var DataSourceArrayForOrderContoller : [[Order]]?
    let btn = UIButton(type: .system)
    let btn2 = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBarDetails()
        self.registerationForCollectionView()
        self.fetchingOrders()
        
    }
    private func fetchingOrders(){
        Service.sharedInstance.fetchOrders { (orders, provinces) in
            let filteredProvinces = CommonMethods.removeDuplicates(array: provinces).sorted()
            self.DataSourceArrayForOrderContoller = CommonMethods.sectionBasedCellPopulation(provinces: filteredProvinces, orders: orders)
            self.collectionView?.reloadData()
        }
    }
    private func setNavBarDetails() {
        navigationItem.title = "Orders"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: CommonMethods.rgbaConvertor(r: 251.0, g: 206.0, b: 110, a: 1.0) ,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 25)]
        navigationController?.navigationBar.barTintColor = CommonMethods.rgbaConvertor(r: 17.0, g: 26.0, b: 27.0, a: 1.0)
    
        btn.setTitle("Back", for: .normal)
        btn.tintColor =  CommonMethods.rgbaConvertor(r: 251.0, g: 206.0, b: 110, a: 1.0)
        btn.addTarget(self, action: #selector(popController), for: .touchUpInside)
        
        btn2.setTitle("2016", for: .normal)
        btn2.tintColor =  CommonMethods.rgbaConvertor(r: 251.0, g: 206.0, b: 110, a: 1.0)
        btn2.addTarget(self, action: #selector(showLastYearOrders), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn2)

    }
    @objc private func popController() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func showLastYearOrders(){
        var lastYearOrders = [[Order]]()
        if let ds = DataSourceArrayForOrderContoller {
            for provinceArray in ds{
                let orderWow = provinceArray.filter({$0.year! == 2016})
                lastYearOrders.append(orderWow)
            }
        }
        btn2.isEnabled = false
        self.DataSourceArrayForOrderContoller = lastYearOrders
        self.collectionView?.reloadData()

    }
    
    
    private func registerationForCollectionView() {
        collectionView?.register(OrderCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView?.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "sectionHeader")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let provincesCount = DataSourceArrayForOrderContoller?.count{
            return provincesCount
        }else{return 1}
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let orderCountPerSection = DataSourceArrayForOrderContoller?[section].count{
            return orderCountPerSection
        }else{return 1}
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as! SectionHeader
        sectionHeader.backgroundColor =  CommonMethods.rgbaConvertor(r: 20.0, g: 29.0, b: 42.0, a: 0.8)
        sectionHeader.order = DataSourceArrayForOrderContoller?[indexPath.section][indexPath.item]
        return sectionHeader
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! OrderCell
        cell.backgroundColor = CommonMethods.rgbaConvertor(r: 255.0, g: 255.0, b: 255.0, a: 1.0)
        cell.order = DataSourceArrayForOrderContoller?[indexPath.section][indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

