//
//  MyOrderModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 11/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation


struct OrderSummaryModel:Codable {
    
    var totalOrder : String?
    var totalAmount : String?
    var processCloth : String?
    var readyCloth : String?
    var myOrderModel : [MyOrderModel]? //this will be the array of QDCOrderDetailModel
    
}




struct MyOrderModel:Codable {
    
    var orderNumber : String?
    var orderDate : String?
    var dueDate : String?
    var totalGarments : String?
    var totalAmount : String?
    var pendingGarment : String?
    var pendingAmount : String?
    var status : String?
    
    
}
