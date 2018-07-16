//
//  MyOrderModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 11/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation


struct OrderModel:Codable {
    
    let OrderSummary : [OrderSummaryModel]?
    let OrderDetails : [OrderDetailsModel]? //this will be the array of QDCOrderDetailModel
    
    
    
}

struct OrderSummaryModel:Codable {
    let TotalOrder : String?
    let TotalAmount : String?
    let ProcessCloth : String?
    let ReadyCloth : String?
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


