//
//  CommonMethods.swift
//  demoApp
//
//  Created by Gokalp Altun on 7/21/18.
//  Copyright © 2018 Gokalp Altun. All rights reserved.
//

import Foundation
import UIKit
class CommonMethods {
    
    public static func sectionBasedCellPopulation(provinces:[String], orders:[Order]) -> [[Order]] {
        var res = [[Order]]()
        for province in provinces{
            res.append([])
            for order in orders{
                if let oprovince = order.province, let index = provinces.index(of: province) {
                    if province == oprovince{
                        res[index].append(order)
                    }
                }
            }
        }
        return res
    }
    
    
    public static func rgbaConvertor(r: CGFloat, g: CGFloat, b: CGFloat, a:CGFloat) -> UIColor {
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha:a)
    }
    
    public static func removeDuplicates(array: [String]) -> [String] {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if encountered.contains(value) {
            }
            else {
                encountered.insert(value)
                result.append(value)
            }
        }
        return result
    }
    
    public static func setBtnViews(pressedButton:UIButton, affectedButton:UIButton){
        pressedButton.isEnabled = false
        pressedButton.backgroundColor = CommonMethods.rgbaConvertor(r: 17.0, g: 26.0, b: 27.0, a: 0.95)
        
        affectedButton.isEnabled = true
        affectedButton.backgroundColor = CommonMethods.rgbaConvertor(r: 17.0, g: 26.0, b: 27.0, a: 1.0)
    }
    public static func sordBasedOnDate(dataSource:[[Order]]?) -> [Order] {
        var listOfOrders = [Order]()
        if let ds = dataSource{
            for province in ds{
                for order in province{
                    listOfOrders.append(order)
                }
            }
        }
        let result = listOfOrders.sorted(by:{
            $0.date! > $1.date!
        })
        return result
    }
}
