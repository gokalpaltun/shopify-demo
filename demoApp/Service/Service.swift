//
//  Service.swift
//  demoApp
//
//  Created by Gokalp Altun on 7/19/18.
//  Copyright © 2018 Gokalp Altun. All rights reserved.
//

import Foundation

class Service {
    
    static let sharedInstance = Service()
    private init (){}
    func fetchOrders(completion:@escaping ([Order] , _ provinces: [String]) ->()){
        let urlStr = Constants.urlStr
        let url = URL(string: urlStr)
        let task = URLSession.shared.dataTask(with: url!) { (data, res, err) in
            if err != nil{
                print(err.debugDescription)
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                let ordersData = json["orders"] as! [[String:AnyObject]]
                
                var orders = [Order]()
                var provinces = [String]()
                
                for orderItem in ordersData {
                    let order = Order()
                    
                    if let shipAddress = orderItem["shipping_address"] as? [String:AnyObject],
                        let address1 = shipAddress["address1"] as? String,
                        let country = shipAddress["country"] as? String,
                        let province = shipAddress["province"] as? String,
                        let countryCode = shipAddress["country_code"] as? String{
                        order.addres = address1 as String + "\n" + province as String + " , " + countryCode as String
                        order.province = province as String
                        order.country = country as String
                        order.countryCode = countryCode as String
                        provinces.append(province)
                    }
                    
                    if let customer = orderItem["customer"] as? [String:AnyObject],
                        let first_name = customer["first_name"] as? String,
                        let last_name = customer["last_name"] as? String{
                        order.customerSurname = last_name
                        order.customerName = first_name
                    }
                    
                    if let email = orderItem["email"] as? String {
                        order.email = email
                    }
                    
                    guard let itemsCount = orderItem["line_items"]?.count else {return}
                    if itemsCount > 1 {
                        order.itemsCount =  ("\(itemsCount as Int) Items")
                    }else{
                        order.itemsCount =  ("\(itemsCount as Int) Item")
                    }
                    
                    guard let totalPrice = orderItem["total_price"] as? String else {return}
                    order.totalPrice = "$" + totalPrice as String
                    
                    guard let date = orderItem["created_at"] as? String else {return}
                    let dateFormatter = ISO8601DateFormatter()
                    let dateType = dateFormatter.date(from: date)
                    let calendar = Calendar.current
                    let year = calendar.component(.year, from: dateType!)
                    order.year = year
                    order.date = dateType
                    
                    
                    orders.append(order)
                }
                DispatchQueue.main.async {
                    completion(orders, provinces)
                }
            }catch(let err){
                print(err)
            }
        };task.resume()
    }
}
