//
//  MyOrderModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 11/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation


struct OrderModel:Codable {
    
    var orderSummaryModel : [OrderSummaryModel]?
    var orderDetailsModel : [OrderDetailsModel]? //this will be the array of QDCOrderDetailModel
    
    
    
}

struct OrderSummaryModel:Codable {
    var TotalOrder : String?
    var TotalAmount : String?
    var ProcessCloth : String?
    var ReadyCloth : String?
}


struct OrderDetailsModel:Codable {
    
    
    /*var orderNumber : String?
    var orderDate : String?
    var dueDate : String?
    var totalGarments : String?
    var totalAmount : String?
    var pendingGarment : String?
    var pendingAmount : String?
    var status : String?*/
    
    var BranchID : String?
    var StoreCode : String?
    var StoreName : String?
    var OrderNo : String?
    var OrderDate : String?
    var DueDate : String?
    var TotalGarments : String?
    var TotalAmount : String?
    var PendingGarment : String?
    var PendingAmount : String?
    var Status : String?
    
    
}


