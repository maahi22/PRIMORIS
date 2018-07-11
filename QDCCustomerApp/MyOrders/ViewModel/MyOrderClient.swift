//
//  MyOrderClient.swift
//  QDCCustomerApp
//
//  Created by Maahi on 11/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit
import Alamofire


class MyOrderClient: NSObject {

    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    func featchMyOrder(completion:@escaping (OrderSummaryModel?,String)->())  {
        
        let branchName = QDCUserDefaults.getDataBaseName()
        let branchID = QDCUserDefaults.getBranchId()
        let clientID = QDCUserDefaults.getClientID()
        let token = QDCUserDefaults.getAccessToken()
        let custId = QDCUserDefaults.getCustomerId()
        
        
        let apiname = MY_ORDERS_RELATIVE_URL + "\(clientID)/\(branchID)/\(custId)"
        let headers = ["token": "\(token)"] as [String:String]
        
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            if let myOrderViewModel = decodeJSON(type: OrderSummaryModel.self, from: data) {
                                                completion(myOrderViewModel, "Success")
                                            }else{
                                                completion(nil,"failed")
                                            }
                                            
        }) { (error, message) in
            
            completion(nil,message)
            
        }
    }
    
    
    
}
