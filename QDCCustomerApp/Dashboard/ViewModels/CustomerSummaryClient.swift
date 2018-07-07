//
//  CustomerSummaryClient.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation
//http://quickdrycleaningclients.com:9002/api/7.1/CustomerSummary/1671/1/Cust1076
import Alamofire
class CustomerSummaryClient: NSObject {
    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    func getCustomerSummary(_ ClientID:String,BranchID:String,CustomerCode:String, OTP:String, token:String,
                            completion:@escaping (CustomerSummaryResponse?,String)->())  {
        
        let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        let customerCode = QDCUserDefaults.getCustomerId()
        let token = QDCUserDefaults.getAccessToken()
        
        let apiname = CUSTOMER_HOME_RELATIVE_URL + "\(clientID)/\(branchID)/\(customerCode)"
        let headers = ["token": "\(token)"] as [String:String]
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            if let customerSummaryResponse = decodeJSON(type: CustomerSummaryResponse.self, from: data) {
                                                completion(customerSummaryResponse, "Success")
                                            }else{
                                                completion(nil,"failed")
                                            }
                                            
        }) { (error, message) in
            
            completion(nil,message)
            
        }
    }
}
