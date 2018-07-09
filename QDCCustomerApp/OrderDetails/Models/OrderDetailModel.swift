//
//  OrderDetailModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation


struct OrderDetailModel:Codable{

    var orderNumber : String?
    var orderDate : String? 
    var dueDate : String?
    var totalGarments : String?
    var totalAmount : String?
    var pendingGarment : String?
    var pendingAmount : String?
    var status : String?

}
