//
//  OrderDetailController.swift
//  demoApp
//
//  Created by Gokalp Altun on 7/21/18.
//  Copyright © 2018 Gokalp Altun. All rights reserved.
//

import UIKit

class OrderSummaryController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var DataSourceArrayForOrderSummary : [[Order]]?
    var OrdersByProvinces : [Int]?
    let detailCollectionView = DetailOrderCollectionView()
    
        private let ordersByProvinceBtn : UIButton = {
            let btn = UIButton(type: .system)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Orders By Province", for: .normal)
            btn.tintColor =  CommonMethods.rgbaConvertor(r: 251.0, g: 206.0, b: 110, a: 1.0)
            btn.backgroundColor = CommonMethods.rgbaConvertor(r: 17.0, g: 26.0, b: 27.0, a: 1.0)
            btn.addTarget(self, action: #selector(ordersByProvinceBtnPressed), for: .touchUpInside)
            return btn
        }()
    
        private let ordersByYearBtn : UIButton = {
            let btn = UIButton(type: .system)
            btn.backgroundColor = .green
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Orders By Year", for: .normal)
            btn.backgroundColor = CommonMethods.rgbaConvertor(r: 17.0, g: 26.0, b: 27.0, a: 1.0)
            btn.tintColor =  CommonMethods.rgbaConvertor(r: 251.0, g: 206.0, b: 110, a: 1.0)
            btn.addTarget(self, action: #selector(ordersByYearBtnPressed), for: .touchUpInside)
            return btn
        }()
        private let spaceBetweenButtons : UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = CommonMethods.rgbaConvertor(r: 177, g: 177, b: 177, a: 1.0)
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 5
            return view
        }()
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .blue
        collectionView?.register(SectionHeaderFirst.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "sectionHeader")
        collectionView?.contentInset = UIEdgeInsetsMake(58, 0, 0, 0)
        ordersByProvinceBtn.isEnabled = false
        fetchingOrders()
        
        self.view.addSubview(ordersByYearBtn)
        self.view.addSubview(ordersByProvinceBtn)
        self.view.addSubview(spaceBetweenButtons)
        
        setNavBarDetails()
        setUpConstraints()
        
    }
    
    @objc private func ordersByYearBtnPressed(){
        detailCollectionView.showCollectionView()
        CommonMethods.setBtnViews(pressedButton: ordersByYearBtn, affectedButton: ordersByProvinceBtn)
        
    }
    
    @objc private func ordersByProvinceBtnPressed(){
        detailCollectionView.dismissCollectionView()
        CommonMethods.setBtnViews(pressedButton: ordersByProvinceBtn, affectedButton: ordersByYearBtn)
    }
    
    private func fetchingOrders(){
        Service.sharedInstance.fetchOrders { (orders, provinces) in
            let filteredProvinces = CommonMethods.removeDuplicates(array: provinces).sorted()
            self.DataSourceArrayForOrderSummary = CommonMethods.sectionBasedCellPopulation(provinces: filteredProvinces, orders: orders)
            self.collectionView?.reloadData()
        }
    }
    private func setNavBarDetails() {
        navigationItem.title = "Orders"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: CommonMethods.rgbaConvertor(r: 251.0, g: 206.0, b: 110, a: 1.0) ,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 25)]
        navigationController?.navigationBar.barTintColor = CommonMethods.rgbaConvertor(r: 17.0, g: 26.0, b: 27.0, a: 1.0)

        let btn = UIButton(type: .system)
        btn.setTitle("Details", for: .normal)
        btn.tintColor =  CommonMethods.rgbaConvertor(r: 251.0, g: 206.0, b: 110, a: 1.0)
        btn.addTarget(self, action: #selector(showOrderDetailsController), for: .touchUpInside)
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        
    }
    
    @objc private func showOrderDetailsController(){
        let collectionViewLayout =  UICollectionViewFlowLayout()
        let controller = OrderDetailController(collectionViewLayout:collectionViewLayout)
        detailCollectionView.dismissCollectionView()
        self.navigationController?.pushViewController(controller, animated: true)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let provincesCount = DataSourceArrayForOrderSummary?.count{
            return provincesCount
        }else{return 1}
        
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as! SectionHeaderFirst
        sectionHeader.backgroundColor =  CommonMethods.rgbaConvertor(r: 20.0, g: 29.0, b: 42.0, a: 0.8)
        if let dataSource = DataSourceArrayForOrderSummary{
            sectionHeader.order = dataSource[indexPath.section][indexPath.item]
            
            sectionHeader.detailLabel.text = "\(dataSource[indexPath.section].count) items ordered"
            
                    
        }
        return sectionHeader
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 100)
    }
    
}
extension OrderSummaryController {
    
    
    func setUpConstraints() {
        ordersByProvinceBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 62).isActive = true
        ordersByProvinceBtn.heightAnchor.constraint(equalToConstant:55).isActive = true
        ordersByProvinceBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        ordersByProvinceBtn.widthAnchor.constraint(equalToConstant: self.view.frame.width*0.5).isActive = true


        ordersByYearBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 62).isActive = true
        ordersByYearBtn.heightAnchor.constraint(equalToConstant:55).isActive = true
        ordersByYearBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        ordersByYearBtn.widthAnchor.constraint(equalToConstant: self.view.frame.width*0.5).isActive = true
        
        spaceBetweenButtons.leadingAnchor.constraint(equalTo: self.ordersByProvinceBtn.trailingAnchor).isActive = true
        spaceBetweenButtons.widthAnchor.constraint(equalToConstant: 1).isActive = true
        spaceBetweenButtons.bottomAnchor.constraint(equalTo: self.ordersByProvinceBtn.bottomAnchor).isActive = true
        spaceBetweenButtons.topAnchor.constraint(equalTo: self.ordersByProvinceBtn.topAnchor).isActive = true

    }
}
