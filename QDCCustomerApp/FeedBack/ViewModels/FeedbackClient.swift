//
//  FeedbackClient.swift
//  QDCCustomerApp
//
//  Created by Maahi on 08/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class FeedbackClient: NSObject {

    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    
    
    
    //schedule details
    func sendFeedBack( messageString:String,
                            completion:@escaping (Bool,String)->())  {
        
//        let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        let customerCode = QDCUserDefaults.getCustomerId()
        let token = QDCUserDefaults.getAccessToken()
        let apiname = FEEDBACK_RELATIVE_URL
        
        
        let params = ["Message": messageString,
                      "BranchID":branchID,
                      "CustomerCode": customerCode,
                      "DatabaseName" :QDCUserDefaults.getDataBaseName()] as [String:Any]
        
        let headers = ["token": "\(token)", "Content-Type": "application/json"] as [String:String]
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .post,
                                           params: params,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            if let scheduleDetailsModel = decodeJSON(type: SchedulePickupModel.self, from: data) {
                                                completion(true, "Success")
                                            }else{
                                                completion(false,"failed")
                                            }
                                            
        }) { (error, message) in
            
            completion(false,message)
            
        }
    }
}
